Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbULGSZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbULGSZj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 13:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbULGSZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 13:25:39 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:21197 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261883AbULGSZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 13:25:12 -0500
Subject: Re: Bug in kmem_cache_create with duplicate names
From: Steven Rostedt <rostedt@goodmis.org>
To: morreale@radiantdata.com
Cc: Arjan van de Ven <arjan@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>, "Randy.Dunlap" <rddunlap@osdl.org>
In-Reply-To: <41B5EF16.30107@radiantdata.com>
References: <1102434056.25841.260.camel@localhost.localdomain>
	 <41B5CD41.9050102@osdl.org>  <1102436157.2882.8.camel@laptop.fenrus.org>
	 <1102436777.25841.271.camel@localhost.localdomain>
	 <1102437079.25841.275.camel@localhost.localdomain>
	 <41B5EF16.30107@radiantdata.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Tue, 07 Dec 2004 13:24:59 -0500
Message-Id: <1102443899.25841.290.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-07 at 10:57 -0700, Peter W. Morreale wrote:

> >
> >Now this raises the issue of name space, this will bug if two modules
> >use the same cache name. If this happens with two different vendors,
> >than the poor user will have to figure out who to blame.
> >
> 
> No different than any other global namespace issue.

I beg to differ. If I have two modules that export the same name, do I
get a bug when I load the second module? No. Actually, I just tried it
and this raises another issue. There is no test to see if there is a
conflict of name spaces. Here's what I did,  I made two modules that
have a function named "abc" and exported them. The third module calls
function "abc".  The result was that both mod1 and mod2 were loaded with
no problem, and mod3 called mod2's abc.  

Below are the simple modules that did this test. Should this be a
problem, or issue? It has a little bit of a polymorphism effect. If I
unload mod3 and then mod2, then reload mod3, it calls mod1's abc (as
expected).  If I unload mod3 again, reload mod2, then reload mod3, it
calls mod2's abc again. 

Well, anyway, I don't think that the kernel should crash due to a
namespace problem with caches. But that's just my opinion. And for all
of you that were so concerned... Yes I did fix my code ;-)



mod1.c:
---------------------------------
#include <linux/config.h>
#include <linux/module.h>
#include <linux/init.h>

void abc(void)
{
	printk("hello from mod1\n");
}

EXPORT_SYMBOL(abc);

static int __init mod1_init(void)
{
	printk("loaded mod1\n");
	return 0;
}

static void __exit mod1_exit(void)
{
	printk("unloaded mod1\n");
}

module_init(mod1_init);
module_exit(mod1_exit);

MODULE_LICENSE("GPL");
----------------------------------------


mod2.c:
----------------------------------------
#include <linux/config.h>
#include <linux/module.h>
#include <linux/init.h>

void abc(void)
{
	printk("hello from mod2\n");
}

EXPORT_SYMBOL(abc);

static int __init mod2_init(void)
{
	printk("loaded mod2\n");
	return 0;
}

static void __exit mod2_exit(void)
{
	printk("unloaded mod2\n");
}

module_init(mod2_init);
module_exit(mod2_exit);

MODULE_LICENSE("GPL");
-------------------------------

mod3.c:
-------------------------------
#include <linux/config.h>
#include <linux/module.h>
#include <linux/init.h>

extern void abc(void);

static int __init mod3_init(void)
{
	printk("loaded mod3\n");

	printk("running abc\n");
	abc();

	return 0;
}

static void __exit mod3_exit(void)
{
	printk("unloaded mod3\n");
}

module_init(mod3_init);
module_exit(mod3_exit);

MODULE_LICENSE("GPL");
-------------------------------------


