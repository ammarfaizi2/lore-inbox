Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262545AbVDAAcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbVDAAcd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 19:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbVDAAcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 19:32:00 -0500
Received: from fire.osdl.org ([65.172.181.4]:12454 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262545AbVDAA3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 19:29:03 -0500
Date: Thu, 31 Mar 2005 16:27:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: johnpol@2ka.mipt.ru
Cc: linux-kernel@vger.kernel.org, guillaume.thouvenin@bull.net,
       jlan@engr.sgi.com, efocht@hpce.nec.com, linuxram@us.ibm.com,
       gh@us.ibm.com, elsa-devel@lists.sourceforge.net, greg@kroah.com
Subject: Re: [1/1] CBUS: new very fast (for insert operations) message bus
 based on kenel connector.
Message-Id: <20050331162758.44aeaf44.akpm@osdl.org>
In-Reply-To: <20050320112336.2b082e27@zanzibar.2ka.mipt.ru>
References: <20050320112336.2b082e27@zanzibar.2ka.mipt.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
>
> I'm pleased to annouce CBUS - ultra fast (for insert operations)
> message bus.

> +static int cbus_enqueue(struct cbus_event_container *c, struct cn_msg *msg)
> +{
> +	int err;
> +	struct cbus_event *event;
> +	unsigned long flags;
> +
> +	event = kmalloc(sizeof(*event) + msg->len, GFP_ATOMIC);

Using GFP_ATOMIC is a bit lame.  It would be better to require the caller
to pass in the gfp_flags.  Or simply require that all callers not hold
locks and use GFP_KERNEL.

> +static int cbus_process(struct cbus_event_container *c, int all)
> +{
> +	struct cbus_event *event;
> +	int len, i, num;
> +	
> +	if (list_empty(&c->event_list))
> +		return 0;
> +
> +	if (all)
> +		len = c->qlen;
> +	else
> +		len = 1;
> +
> +	num = 0;
> +	for (i=0; i<len; ++i) {
> +		event = cbus_dequeue(c);
> +		if (!event)
> +			continue;
> +
> +		cn_netlink_send(&event->msg, 0);
> +		num++;
> +
> +		kfree(event);
> +	}
> +	
> +	return num;
> +}

It might be cleaner to pass in an item count rather than a boolean `all'
here.  Then again, it seems racy.

The initial list_empty() call could fail to detect new events due to lack
of locking and memory barriers.

We conventionally code for loops as

	for (i = 0; i < len; i++)

> +static int cbus_event_thread(void *data)
> +{
> +	int i, non_empty = 0, empty = 0;
> +	struct cbus_event_container *c;
> +
> +	daemonize(cbus_name);
> +	allow_signal(SIGTERM);
> +	set_user_nice(current, 19);

Please use the kthread api for managing this thread.

Is a new kernel thread needed?

> +	while (!cbus_need_exit) {
> +		if (empty || non_empty == 0 || non_empty > 10) {
> +			interruptible_sleep_on_timeout(&cbus_wait_queue, 10);

interruptible_sleep_on_timeout() is heavily deprecated and is racy without
external locking (it pretty much has to be the BKL).  Use wait_event_timeout().

> +int __devinit cbus_init(void)
> +{
> +	int i, err = 0;
> +	struct cbus_event_container *c;
> +	
> +	for_each_cpu(i) {
> +		c = &per_cpu(cbus_event_list, i);
> +		cbus_init_event_container(c);
> +	}
> +
> +	init_completion(&cbus_thread_exited);
> +
> +	cbus_pid = kernel_thread(cbus_event_thread, NULL, CLONE_FS | CLONE_FILES);

Using the kthread API would clean this up.

> +	if (IS_ERR((void *)cbus_pid)) {

The weird cast here might not even work at all on 64-bit architectures.  It
depends if they sign extend ints when casting them to pointers.  I guess
they do.  If cbus_pid is indeed an s32.

Much better to do

	if (cbus_pid < 0)

> +void __devexit cbus_fini(void)
> +{
> +	int i;
> +	struct cbus_event_container *c;
> +
> +	cbus_need_exit = 1;
> +	kill_proc(cbus_pid, SIGTERM, 0);
> +	wait_for_completion(&cbus_thread_exited);
> +	
> +	for_each_cpu(i) {
> +		c = &per_cpu(cbus_event_list, i);
> +		cbus_fini_event_container(c);
> +	}
> +}

I think this is racy.  What stops new events from being queued while this
function is in progress?

