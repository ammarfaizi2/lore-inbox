Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289929AbSAKMYa>; Fri, 11 Jan 2002 07:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289930AbSAKMYV>; Fri, 11 Jan 2002 07:24:21 -0500
Received: from petasus.iil.intel.com ([192.198.152.69]:7922 "EHLO
	petasus.iil.intel.com") by vger.kernel.org with ESMTP
	id <S289929AbSAKMYL>; Fri, 11 Jan 2002 07:24:11 -0500
Message-ID: <3C3ED949.4030604@intel.com>
Date: Fri, 11 Jan 2002 14:23:37 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Organization: Intel
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, Nick Craig-Wood <ncw@axis.demon.co.uk>
Subject: Re: __FUNCTION__ - patch for USB
In-Reply-To: <3C3CC04D.2080807@intel.com> <20020109222657.GA23143@kroah.com> <3C3D7289.9000302@intel.com> <20020110160927.GA26783@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>You still are changing a few dbg() macros that you don't have to change.
>
Guilty. Goal was to force some common style. There are mix of function 
call styles like f() and f (). I suppose f() (without space between 
function name and parenthes) is better, but it is of course religious 
issue and have no 'proper' solution.

>
>Also, info(), warn() and err() should not have __FUNCTION__ added to
>them.  Have you tried running the usb code with this patch?  The USB
>group gets enough grief about all of the kernel log messages that we
>spit out.  We do not need to see the function name for every message we
>write (the user does not need it.)
>
Questionable. There are lots of calls that used to have __FUNCTION__, 
ex. 1-st chunks from patch are:

--- linux-2.4.18-pre2.orig/drivers/usb/CDCEther.c       Fri Dec 21 
19:41:55 2001
+++ linux-2.4.18-pre2.patched/drivers/usb/CDCEther.c    Thu Jan 10 
10:28:21 2002
-               warn( __FUNCTION__ " failed submint rx_urb %d", res);
+               warn("failed submint rx_urb %d", res);
-               err( "write_bulk_callback: device not running" );
+               err( "device not running" );

It is hard to be both flexible and easy. I suppose always have function 
name in the log is a good idea. Maybe, I would even add line number. 
Anyway, original macros used to add __FILE__ prefix. All these stuff 
goes to syslog, and user usually do not see it at all. If one wants to 
browse /var/log/messages, he is supposed to understand a little what he 
going to see, and function names may help.
In places where great flexibility is required, I'd propose to keep using 
printk().

>
>I think I'll wait for the debug level messages cleanup in the 2.5 USB
>code to make this kind of change (as talked about in a previous
>message.)
>
>thanks,
>
>greg k-h
>
What about macros for simple one line messages for generic usage? Any 
thoughts?
I propose the following messages format:

<module>:<file>:<line>:<function> - <message_text>

Corresponded macro would be, for example:

#ifdef MODULE
#define err(format, arg...) printk(KERN_ERR "%s:%s:%d:%s - " format "\n" 
,THIS_MODULE->name ,__FILE__, __LINE__, __FUNCTION__, ## arg)
#else
#define err(format, arg...) printk(KERN_ERR "%s:%d:%s - " format "\n" , 
__FILE__, __LINE__, __FUNCTION__, ## arg)
#endif



