Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWEGNJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWEGNJc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 09:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWEGNJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 09:09:32 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:20938
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S932152AbWEGNJb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 09:09:31 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Sergey Vlasov <vsu@altlinux.ru>, gregkh@suse.de
Subject: Re: [patch 2/6] New Generic HW RNG
Date: Sun, 7 May 2006 15:16:08 +0200
User-Agent: KMail/1.9.1
References: <20060507113513.418451000@pc1> <20060507113604.778384000@pc1> <20060507170320.3ce0d3e0.vsu@altlinux.ru>
In-Reply-To: <20060507170320.3ce0d3e0.vsu@altlinux.ru>
Cc: akpm@osdl.org, Deepak Saxena <dsaxena@plexity.net>,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200605071516.09167.mb@bu3sch.de>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 May 2006 15:03, you wrote:
> This does not handle the case of partial read correctly - the code
> should be
> 
> 			return ret ? : -ERESTARTSYS;
> 
> > +		if (!current_rng) {
> > +			mutex_unlock(&rng_mutex);
> > +			return -ENODEV;
> 
> The same problem here (although finding the RNG suddenly missing after
> we heve just read something from it is pretty unlikely).
> 
> > +		}
> > +		have_data = 0;
> > +		if (current_rng->data_present == NULL ||
> > +		    current_rng->data_present(current_rng))
> > +			have_data = current_rng->data_read(current_rng, &data);
> > +		mutex_unlock(&rng_mutex);
> > +
> > +		while (have_data && size) {
> > +			if (put_user((u8)data, buf++)) {
> > +				ret = ret ? : -EFAULT;
> > +				break;
> > +			}
> > +			size--;
> > +			ret++;
> > +			have_data--;
> > +			data>>=8;
> > +		}
> > +
> > +		if (filp->f_flags & O_NONBLOCK)
> > +			return ret ? : -EAGAIN;
> > +
> > +		if (need_resched()) {
> > +			schedule_timeout_interruptible(1);
> > +		} else {
> > +			err = mutex_lock_interruptible(&rng_mutex);
> > +			if (err)
> > +				return err;
> 
> And here...
> 
> > +			if (!current_rng) {
> > +				mutex_unlock(&rng_mutex);
> > +				return -ENODEV;
> 
> And here too.

Whoops, will fix these.

> > +	list_for_each_entry(rng, &rng_list, list) {
> > +		if (strncmp(rng->name, buf, len) == 0) {
> 
> This will match if the passed string is just a prefix of rng->name.
> Apparently sysfs guarantees that the buffer passed to ->store will be
> NUL-terminated, so this should be just a strcmp().

I am not sure if it is guaranteed NUL terminated. Greg?
But I will look into this.

> > +			if (rng->init) {
> > +				err = rng->init(rng);
> > +				if (err)
> > +					break;
> > +			}
> > +			if (current_rng && current_rng->cleanup)
> > +				current_rng->cleanup(current_rng);
> 
> What if rng == current_rng here (someone has written the same RNG name
> to the "store" attribute)?  The lowlevel RNG driver should not have to
> handle nested init/cleanup calls.

I see. Will fix this.


I will also fix the bcm43xx patch. It registers always with the same "name".
That will blow up, if there is more than one bcm43xx device in the system.

-- 
Greetings Michael.
