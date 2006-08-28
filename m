Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWH1GEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWH1GEL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 02:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWH1GEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 02:04:11 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:13971 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751367AbWH1GEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 02:04:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=dMLQzgjL9Ix1YxDrGNNvVN0ZbHhmocHXs6gSTPj3dE6fKBXYgpbzteGGj+VG6glmsMhI6RgQrom0ejY3KYPZW+gWQt6RftPzoeHUQYpXzAliuYafk08Ci7n55ZFBH27wA/XU1txnt3jxbBqpJAX68FyXoZw/Hn10fXiIIfAYBvs=
Message-ID: <44F286E8.1000100@gmail.com>
Date: Mon, 28 Aug 2006 09:02:16 +0300
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johninsd@san.rr.com, Matt_Domsch@dell.com
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
 (ping)
References: <445B5524.2090001@gmail.com> <200608272116.23498.ak@suse.de> <44F1F356.5030105@zytor.com> <200608272254.13871.ak@suse.de> <44F21122.3030505@zytor.com>
In-Reply-To: <44F21122.3030505@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Found the references.  This seems to imply that EDD overwrites the area 
> used by LILO 22.6.1.  LILO 22.6.1 uses the new boot protocol, with the 
> full pointer, and seems to obey the spec as far as I can read the code. 
>  I'm going to try to run it in simulation and observe the failure that way.
> 
> However, something is still seriously out of joint.  The EDD data 
> actually overlays the setup code, not the bootsect code, and thus there 
> "shouldn't" be any way that this could interfere.  My best guess at this 
> time is that either the EDD code or LILO uses memory it's not supposed 
> to use, and the simulation should hopefully reveal that.
> 
> Sorry if I seem snarky on this, but if we can't get to the bottom of 
> this we can't ever fix it.
> 
>     -hpa
> 

I think I've found one problem... But I it should not be the major one.
The EDD code scans the command-line as fixed string.
What about something like the following?

Best Regards,
Alon Bar-Lev.

diff -urNp linux-2.6.18-rc4-mm2/arch/i386/boot/edd.S linux-2.6.18-rc4-mm2.new/arch/i386/boot/edd.S
--- linux-2.6.18-rc4-mm2/arch/i386/boot/edd.S   2006-06-18 04:49:35.000000000 +0300
+++ linux-2.6.18-rc4-mm2.new/arch/i386/boot/edd.S       2006-08-28 08:55:01.000000000 +0300
@@ -29,6 +29,8 @@
         movl    $(COMMAND_LINE_SIZE-7), %ecx
  # loop through kernel command line one byte at a time
  cl_loop:
+       cmpb    $0,(%si)
+       jz      done_cl
         cmpl    $EDD_CL_EQUALS, (%si)
         jz      found_edd_equals
         incl    %esi
