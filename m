Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVB1HUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVB1HUs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 02:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVB1HUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 02:20:48 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:1681 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261159AbVB1HUi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 02:20:38 -0500
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, davem@redhat.com, jlan@sgi.com,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
       elsa-devel <elsa-devel@lists.sourceforge.net>
In-Reply-To: <42227AEA.6050002@ak.jp.nec.com>
References: <42168D9E.1010900@sgi.com>
	 <20050218171610.757ba9c9.akpm@osdl.org> <421993A2.4020308@ak.jp.nec.com>
	 <421B955A.9060000@sgi.com> <421C2B99.2040600@ak.jp.nec.com>
	 <421CEC38.7010008@sgi.com> <421EB299.4010906@ak.jp.nec.com>
	 <20050224212839.7953167c.akpm@osdl.org> <20050227094949.GA22439@logos.cnet>
	 <4221E548.4000008@ak.jp.nec.com> <20050227140355.GA23055@logos.cnet>
	 <42227AEA.6050002@ak.jp.nec.com>
Date: Mon, 28 Feb 2005 08:20:36 +0100
Message-Id: <1109575236.8549.14.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 28/02/2005 08:29:35,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 28/02/2005 08:29:38,
	Serialize complete at 28/02/2005 08:29:38
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-28 at 10:59 +0900, Kaigai Kohei wrote:
> Marcelo Tosatti wrote:
>  > Yep, the netlink people should be able to help - they known what would be
>  > required for not sending messages in case there is no listener registered.
>  >
>  > Maybe its already possible? I have never used netlink myself.
> 
> If we notify the fork/exec/exit-events to user-space directly as you said,
> I don't think some hackings on netlink is necessary.
> For example, such packets is sent only when /proc/sys/.../process_grouping is set,
> and user-side daemon set this value, and unset when daemon will exit.
> It's not necessary to take too seriously.

  I wrote a new fork connector patch with a callback to enable/disable
messages in case there is or isn't listener. I will post it this week.

  Basically there is a global variable that is manipulated with a
connector callback so a user space daemon can manipulate the variable.
In the fork_connector() function you have:

static inline void fork_connector(pid_t parent, pid_t child)
{
	static DEFINE_SPINLOCK(cn_fork_lock);
	static __u32 seq;   /* used to test if message is lost */

	if (cn_fork_enable) {
		[...]
		cn_netlink_send(msg, CN_IDX_FORK);
	}
}

and in the cn_fork module (drivers/connector/cn_fork.c) the callback is
defined as:

static void cn_fork_callback(void *data) 
{
	if (cn_already_initialized)
		cn_fork_enable = cn_fork_enable ? 0 : 1;
}

  Ok the protocol is maybe too "basic" but with this mechanism the user
space application that uses the fork connector can start and stop the
send of messages. This implementation needs somme improvements because
currently, if two application are using the fork connector one can
enable it and the other don't know if it is enable or not, but the idea
is here I think.

Regards,
Guillaume

