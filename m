Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262351AbRENSMl>; Mon, 14 May 2001 14:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262367AbRENSMb>; Mon, 14 May 2001 14:12:31 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:28346 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262351AbRENSM1>;
	Mon, 14 May 2001 14:12:27 -0400
Message-ID: <3B002001.AEEEE415@mandrakesoft.com>
Date: Mon, 14 May 2001 14:12:17 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
Cc: Andrew Morton <andrewm@uow.edu.au>, davem@redhat.COM,
        linux-kernel@vger.kernel.org
Subject: Re: NETDEV_CHANGE events when __LINK_STATE_NOCARRIER is modified
In-Reply-To: <200105141747.VAA15542@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> 
> Hello!
> 
> > Jeff has introduced `alloc_etherdev()' which allocates storage
> > for a netdev but doesn't register it.  The one quirk with this
> > approach (and why it's vastly simpler than my thing)
> 
> I do not see where it is simpler. The only difference is that
> name is unknown. 8)

Note that using dev->name during probe was always incorrect.  Think
about the error case:

device 0:
	dev = init_etherdev(...); /* gets if eth0 */
	printk(... dev->name ...)
	/* prints "eth0: error foo, aborting" */
	failure!  exit and unregister_netdev
device 1:
	dev = init_etherdev(...); /* gets if eth0 */
	printk(... dev->name ...)
	/* prints "eth0: error foo, aborting" */
	failure!  exit and unregister_netdev
device 2:
	dev = init_etherdev(...); /* gets if eth0 */
	printk(... dev->name ...)
	/* prints "eth0: error foo, aborting" */
	failure!  exit and unregister_netdev

So, using interface name in this manner was always buggy because it
conveys no useful information to the user.


> What's about dev_probe_lock, I again do not understand why it is not deleted.
> Please, shed some light.

I'm all for removing it...  I do not like removing it in a so-called
"stable" series, though.  alloc_etherdev() was enough to solve the race
and flush out buggy drivers using dev->name during probe.  Notice I did
not remove init_etherdev and fix it properly -- IMHO that is 2.5
material.

	Jeff


-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
