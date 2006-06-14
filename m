Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWFNM3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWFNM3P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 08:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWFNM3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 08:29:14 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:30443 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751286AbWFNM3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 08:29:14 -0400
Message-ID: <350288150.07136@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Wed, 14 Jun 2006 20:29:34 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, Lubos Lunak <l.lunak@suse.cz>,
       Dirk Mueller <dmueller@suse.de>, Badari Pulavarty <pbadari@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] the /proc/filecache interface
Message-ID: <20060614122934.GB6564@mail.ustc.edu.cn>
Mail-Followup-To: Fengguang Wu <fengguang.wu@gmail.com>,
	Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
	Lubos Lunak <l.lunak@suse.cz>, Dirk Mueller <dmueller@suse.de>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>
References: <20060612075130.GA5432@mail.ustc.edu.cn> <20060614110542.GE28536@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060614110542.GE28536@elf.ucw.cz>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Wed, Jun 14, 2006 at 01:05:42PM +0200, Pavel Machek wrote:
> > The /proc/filecache support has been half done. And I'd like to hear
> > early comments on the interface.
> > 
> > (The patch is not quite ready for code reviews. It is attached in case
> > someone are interested to have it a try.)
> 
> I guess this is going to be nice for loading cache after
> suspend-to-disk and for the fast boot, but...

Thanks.

> > SAMPLE OUTPUT
> > 
> > root ~# echo -n ALL > /proc/filecache
> > root ~# head /proc/filecache
> > # file ALL
> > #      ino       size   cached cached%  state   refcnt  uid     gid     dev             file
> >     413605         23       24    100   --      0       0       0       03:00(hda)      /sbin/modprobe
> >     381701         17       20    100   --      1       0       0       03:00(hda)      /bin/cat
> >     398088          1        4    100   --      0       0       0       03:00(hda)      /root/bin/checkpath
> >     381698        611      612    100   --      1       0       0       03:00(hda)      /bin/bash
> >     159498          1        4    100   --      0       0       0       03:00(hda)      /etc/mtab
> >     381719         30       32    100   --      0       0       0       03:00(hda)      /bin/rm
> >     335993          4        4    100   --      0       0       43      03:00(hda)      /var/run/utmp
> >          0    3687424      828      0   --      0       0       0       00:02(bdev)     03:00
> >     159701          5        8    100   --      0       0       0       03:00(hda)      /etc/modprobe.d/aliases
> >      31866       1238     1240    100   --      4       0       0       03:00(hda)      /lib/tls/libc-2.3.5.so
> >     381705         51       52    100   --      0       0       0       03:00(hda)      /bin/cp
> >      31814         27       28    100   --      0       0       0       03:00(hda)      /lib/libblkid.so.1.0
> >     159534         17       20    100   --      0       0       0       03:00(hda)      /etc/ld.so.cache
> > [...]
> 
> > root ~# echo -n /lib/tls/libc-2.3.5.so > /proc/filecache
> > root ~# head /proc/filecache
> > # file /lib/tls/libc-2.3.5.so
> > # flags LK:locked ER:error RF:referenced UD:uptodate DT:dirty AC:active SL:slab CK:checked A1:arch_1 RS:reserved PV:private WB:writeback NS:nosave CP:compound SC:swapcache MD:mappedtodisk RC:reclaim ns:nosave_free RA:readahead MM:mmap
> > # idx   len                     state                   	refcnt  location
> > 0       21      ____RFUD__AC__________________MD______MM        4       0.0.Normal
> > 21      1       ____RFUD__AC__________________MD______MM        3       0.0.Normal
> > 22      3       ______UD______________________MD________        1       0.0.Normal
> > 25      1       ____RFUD__AC__________________MD______MM        2       0.0.Normal
> > 26      2       ______UD______________________MD________        1       0.0.Normal
> > 28      1       ______UD______________________MD____RA__        1       0.0.Normal
> > 29      2       ______UD______________________MD________        1       0.0.Normal
> 
> The interface is really too ugly to live. How do you expect it being
> used from two programs, simultaneously?

Yes, it can be used by two programs without interfering each other :)
The trick goes in this way:
        - program A, B each opened the /proc/filecache for querying
        - A calls fdA = open("/proc/filecache")
        - B calls fdB = open("/proc/filecache")
        - A calls write(fdA, "file /lib/tls/libc-2.3.5.so") to set
          parameter, which will be stored in fileA->f_version.
        - the same for B
        - so A, B each has its own working parameter.

There is also a global parameter, which will be used if the program
has not call write() to set his own parameter. I'll take care so that
programs that query the interface do not pollute the global default
parameter:
        - open(); write(); close()
                save the private parameter as the global default
        - open(); write(); ...; read(); close()
                do not touch the global parameter
        - open(); read(); close()
                initialize the private parameter with the global default

> We don't really want to do ascii pretty-printing in kernel, sorry. It

You mean the page flags? I bet sysadms would like it ;)
Another consideration of not using hex numbers is to prevent
PG_referenced being adapted to 12 someday.

And I never mean to expose so much flags. If any page flag is supposed
to be useless for the user(i.e. SL:slab), please let me know, thanks.

> probably needs to go into /sys , and be redesigned to provide "one
> value per file" rule...

I choose not to use /sys to avoid overheads. It requires allocating
much more structs, and injecting hooks to respond to inode
create/remove events.

Thanks,
Wu
