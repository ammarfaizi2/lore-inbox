Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbVISNVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbVISNVm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 09:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbVISNVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 09:21:42 -0400
Received: from nproxy.gmail.com ([64.233.182.196]:48159 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932353AbVISNVl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 09:21:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J9dpyGVECaA86hCeC+3T+FVNQ2oT7gQIoyD+h0XS2HZM7HozPpm9mcMahlLVB4hknFKu91UFVd0k4nbOeKCzq/kDMh5ChpX1Q5sLYpKzp35UpqywETJ7Or6P8sexxNjVQM+iixKTqmitonpy4OVZaIUJsqYfri1nH9VsjGfvpoU=
Message-ID: <2cd57c90050919062144d133c9@mail.gmail.com>
Date: Mon, 19 Sep 2005 21:21:38 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@gmail.com
To: Ustyugov Roman <dr_unique@ymg.ru>
Subject: Re: [BUG] module-init-tools
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <200509191432.58736.dr_unique@ymg.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509191432.58736.dr_unique@ymg.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/05, Ustyugov Roman <dr_unique@ymg.ru> wrote:
> Hello!
> 
> I found a bug in module-init-tools.
> 
> 'lsmod' shows a wrong module name, when module name complied with some
> "define" at one of kernel header files.
> 
> For example,
> 
> File "current.c"
> =======================
> #include <linux/kernel.h>
> #include <linux/module.h>
> 
> int init_module(void) {
> 
>   return 0;
> }
> 
> void cleanup_module() {
> }
> 
> MODULE_LICENSE("GPL");
> =======================
> 
> Makefile:
> 
> =======================
> obj-m += current.o
> =======================
> 
> Make this module and type commands:
> 
> insmod current.ko
> lsmod
> 
> And we can see:
> 
> Module Size Used by
> get_current() 1152 0 <---- Oops, must be 'current'
> smbfs 61432 2
> hfsplus 56708 0
> nls_cp866 5120 1
> nls_iso8859_1 4096 0
> nls_cp437 5760 0
> vfat 12800 0
> fat 37916 1 vfat
> nls_utf8 2048 1
>   .....
> 
> File <asm/current.h>:
> 
> ===================
>   ...
> #define current get_current()
>   ...
> ===================
> 
> Try to remove module:
> 
> romanu:/current # rmmod current
> ERROR: Module current does not exist in /proc/modules
> romanu:/current # rmmod -v "get_current()"
> rmmod get_current(), wait=no
> romanu:/current #
> 
> I can't remove module with 'rmmod current',
> but can with
> rmmod "get_current()"
> 
> Is it a bug?
> 
> Then, next example.
> 
> File 'init_stack.c'
> =================
> #include <linux/kernel.h>
> #include <linux/module.h>
> 
> int init_module(void) {
> 
>   return 0;
> }
> 
> void cleanup_module() {
> }
> 
> MODULE_LICENSE("GPL");
> =================
> 
> Make and insert module 'init_stack.ko':
> 
> lsmod:
> 
> Module Size Used by
> get_current() 1152 0
> (init_thread_union.stack) 1152 0 <---- Oops, must be 'init_stack'
> smbfs 61432 2
> hfsplus 56708 0
> nls_cp866 5120 1
> nls_iso8859_1 4096 0
> 
> Now I can't to remove it at all ! :(:(
> 
> From <asm/thread_info.h>
> 
> ====================
> ...
> #define init_stack (init_thread_union.stack)
> ...
> ====================
> 
> Some information about software:
> 
> OS: SuSE Pro 9.3
> kernel version: 2.6.11.4-21.8-default
> module-init-tools version: 3.2_pre1-7

Actually, this is a kbuild bug, not module-init-tools' fault. 

(cc Sam)

-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
