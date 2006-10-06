Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWJFQVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWJFQVE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 12:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWJFQVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 12:21:03 -0400
Received: from xenotime.net ([66.160.160.81]:42970 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751391AbWJFQVB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 12:21:01 -0400
Date: Fri, 6 Oct 2006 09:22:28 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Cc: Witold =?UTF-8?Q?W=C5=82adys=C5=82aw?= Wojciech Wilk 
	<witold.wilk@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: how to get the kernel to be more "verbose"?
Message-Id: <20061006092228.a22cf9ba.rdunlap@xenotime.net>
In-Reply-To: <20061006073303.GA5105@cepheus.pub>
References: <98975a8b0610052234p3287ab8fr70335f858ba4583b@mail.gmail.com>
	<20061006073303.GA5105@cepheus.pub>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2006 09:33:03 +0200 Uwe Zeisberger wrote:

> Hello Witold,
> 
> Witold Władysław Wojciech Wilk wrote:
> > I've tried using the /proc/config.gz provided by the default kernel,
> > but to no avail.
> Does this mean, you cannot find the config because /proc/config.gz
> doesn't exist?  Then try /boot/config-2.6.8.  Maybe I misunderstood you?
>  
> > The next step of loading the kernel I have seen in various logs is the
> > TCP/IP stack, am I right? 
> I think offically the initcalls are in no particular order, but in
> practice in depends on the linking order.  For my kernel the next line
> is
> 
> 	IP route cache hash table entries: 32768 (order: 5, 131072 bytes)

They are in initcall section order and within those sections they
are in link order.  From include/linux/init.h:

/* initcalls are now grouped by functionality into separate 
 * subsections. Ordering inside the subsections is determined
 * by link order. 
 * For backwards compatibility, initcall() puts the call in 
 * the device init subsection.
 */

#define __define_initcall(level,fn) \
	static initcall_t __initcall_##fn __attribute_used__ \
	__attribute__((__section__(".initcall" level ".init"))) = fn

#define core_initcall(fn)		__define_initcall("1",fn)
#define postcore_initcall(fn)		__define_initcall("2",fn)
#define arch_initcall(fn)		__define_initcall("3",fn)
#define subsys_initcall(fn)		__define_initcall("4",fn)
#define fs_initcall(fn)			__define_initcall("5",fn)
#define device_initcall(fn)		__define_initcall("6",fn)
#define late_initcall(fn)		__define_initcall("7",fn)

> > Any help? Please point me at something, I am trying for two weeks
> > already, and I cannot find any problems like mine. Thanks a lot for
> > any help.
> You can try the "initcall_debug" kernel parameter to see which init
> functions are called.

You can also add "debug" to the boot options.  That will make the
kernel more verbose, but beware, some distro's init scripts
change the loglevel during bootup, so it may not have effect for
very long.

And if you have a second machine, you can use netconsole or serial
console (depending on hardware) to capture boot messages.
The "earlyprintk" option could help here.  Even without a second
machine, using "earlyprintk=vga" might help.

---
~Randy
