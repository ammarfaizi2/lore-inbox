Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267519AbUG2XZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267519AbUG2XZi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 19:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267531AbUG2XZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 19:25:37 -0400
Received: from home.powernetonline.com ([66.84.210.20]:27582 "EHLO
	home.uspower.net") by vger.kernel.org with ESMTP id S267519AbUG2XZX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 19:25:23 -0400
Date: Thu, 29 Jul 2004 18:25:47 -0500
From: John Lenz <jelenz@students.wisc.edu>
To: Andrew Zabolotny <zap@homelink.ru>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: Backlight and LCD module patches [2]
Message-ID: <20040729232547.GA4565@hydra.mshome.net>
References: <20040617223517.59a56c7e.zap@homelink.ru> <20040725215917.GA7279@hydra.mshome.net> <20040728221141.158d8f14.zap@homelink.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed	DelSp=Yes
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040728221141.158d8f14.zap@homelink.ru> (from zap@homelink.ru on Wed, Jul 28, 2004 at 13:11:41 -0500)
X-Mailer: Balsa 2.0.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/28/04 13:11:41, Andrew Zabolotny wrote:
> On Sun, 25 Jul 2004 16:59:17 -0500
> John Lenz <jelenz@students.wisc.edu> wrote:
> 
>>  The problem I see is that we would like something like a bus to   
>> match  together class devices.  What would be really nice is  
>> something  like   this.
>  This is impossible to do in a device-independent way. Only the   
> drivers  know  how they can recognize each other. And if you're  
> meaning the b/l  driver will  register the match function with the  
> core, that's very similar to the  solution  I've described in my  
> earlier messages.

That's what the match callback function is for.  The class match stuff  
does not try and match anything together itself.  The provided match  
callback function would have to do all the device specific matching  
that needs to take place.  All the class_match stuff would do is make  
sure the match function is called with every possible combination of fb  
device and lcd device.

That is, we could remove the lcd_fb_list and lcd_device_list from this  
patch because the class code would handle making sure the match  
function is called.  The class_match->match function in the lcd_device  
driver would then call the lcd_properties->match function.

Secondly, we also wouldn't need to call lcd_fb_info_register from the  
fb code either, since the fb code would register a class_device and  
then the class_match code would attempt to match that fb device with a  
lcd device by calling the lcd provided match function.

(This is a little problematic since the fb code uses simple_class, so  
there would need to be some changes there for this to take place... see  
below)

And we wouldn't need to reimplement those lists and rewrite all that  
matching stuff in every driver (LED, Backlight, LCD)

>  Speaking of your patch, I don't like the lcd_power_names array. The   
> reason for  the 0-4 power status was to match that of VESA power  
> states (0..4,  intermediate values mean intermediate power states,  
> whatever they  mean  for  concrete devices). Besides, it makes end- 
> user usage more complex  (instead of  just specifying a number in the  
> 0-4 range you now have to *know* you  have to  specify "full off" and  
> alike). Also it doesn't handle backlight, only  LCD.

Ok.  I just tried to make it a little more verbose.  That is easy to  
change back.

I was more proposing the type of matching between fb and lcd devices  
that happens in this patch.  It is completly independent of the base  
code, each individual lcd device will implement a function to determine  
if it is the lcd device for the given fb device.

Actually, now that I think about it a bit more, I think the  
lcd_properties->match function should take a device * as a paramater  
instead of a fb_info *.  Insead of passing the fb_info pointer to the  
match function, we really should be passing the actual device  
structure.  For example, in the pxafb driver, it would register the  
platform_device that it creates with either the class code (if  
class_match is used) or with the lcdbase code.  This way the lcd driver  
could examine the device * and look at for example which resources it  
used, which memory region it was using, etc. and make its decision.

That is, I see two options
1) We use class_match.  Then we add an (optional) paramater to  
register_framebuffer in fbmem.c which would be a device *.  This device  
* would just be passed along to the class_simple_device_add function  
and nothing else.  In this way the class_match->match function would be  
able to extrat that device * and pass that along to the lcd_properties-
>match function.

2) class_match doesn't get added.  Instead we just call  
lcd_fb_device_register(struct device *) directly from the pxafb code  
with the platform_device as a paramater.

I would vote for number 1.
