Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWI3QqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWI3QqL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 12:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWI3QqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 12:46:10 -0400
Received: from xenotime.net ([66.160.160.81]:30693 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751274AbWI3QqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 12:46:09 -0400
Date: Sat, 30 Sep 2006 09:47:31 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Seongsu Lee <senux@senux.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: specifying the order of calling kernel functions (or modules)
Message-Id: <20060930094731.2fe41e12.rdunlap@xenotime.net>
In-Reply-To: <20060930104205.GB10248@pooky.senux.com>
References: <20060928101724.GA18635@pooky.senux.com>
	<200609281547.k8SFl3Au004978@turing-police.cc.vt.edu>
	<20060930104205.GB10248@pooky.senux.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Sep 2006 19:42:05 +0900 Seongsu Lee wrote:

> On Thu, Sep 28, 2006 at 11:47:02AM -0400, Valdis.Kletnieks@vt.edu wrote:
> > On Thu, 28 Sep 2006 19:17:24 +0900, Seongsu Lee said:
> > > I am a beginner of kernel module programming. I want to
> > > specify the order of calling functions that I registered
> > > by EXPORT_SYMBOL(). (or modules)
> > 
> > What problem did you expect to solve by specifying the order?  Phrased
> > differently, why does the order matter?
> 
> I am playing with mtdconcat in MTD (Memory Technology Device).
> 
> For example:
>   mtdconcat must be called after initializing the lower device and
>   partitions. So, the order of calling functions must be decided
>   always.
> 
> Actuall, the functions in Linux kernel are called in a order. I want
> to know how to specify these orders.
> 
> Sorry for short English. Thank you for your help.

a.  linker order matters (order in Makefiles)

b.  initcall order matters.  See include/linux/init.h, especially
this part:

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


c.  "function call" order matters :)


---
~Randy
