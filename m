Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288447AbSAHVhQ>; Tue, 8 Jan 2002 16:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288442AbSAHVhH>; Tue, 8 Jan 2002 16:37:07 -0500
Received: from petasus.iil.intel.com ([192.198.152.69]:15823 "EHLO
	petasus.iil.intel.com") by vger.kernel.org with ESMTP
	id <S288435AbSAHVgw>; Tue, 8 Jan 2002 16:36:52 -0500
Message-ID: <3C3B664B.3060103@intel.com>
Date: Tue, 08 Jan 2002 23:36:11 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Organization: Intel
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: __FUNCTION__
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Modern C standard (C99) defines __FUNCTION__ as if immediately after 
function open brace string with function name is declared. Thus, it's 
invalid to use string concatenations like __FILE__ ":" __FUNCTION__.

Gcc 3.03 gives warning for such use of __FUNCTION__. Before this 
warnings become error, it's worth to fix this in the kernel source.

I found tons of improper __FUNCTION__ usage in USB drivers. I am not to 
say, USB is the only place, I just started with it. In USB, typical use 
is with dbg() and alike macros. dbg() defined in usb.h as follows:

#define dbg(format, arg...) printk(KERN_DEBUG __FILE__ ": " format "\n" 
, ## arg)

In source it is usually used like

dbg(__FUNCTION__ " endpoint %d\n", usb_pipeendpoint(this_urb->pipe));

I propose modification for dbg() and friends like

#define dbg(format, arg...) printk(KERN_DEBUG __FILE__ ":%s - " format 
"\n", __FUNCTION__, ## arg)

This will enable the same usage, but will incorporate __FUNCTION__ in 
the common message prefix. This centralization will force function name 
in all messages, and make it easy to fix code. Code will be shorter and 
cleaner. It may be worth to (#ifdef MODULE) add module name to message 
prefix.

Any comments?

Please, when replying, CC me: mailto:vladimir.kondratiev@intel.com



