Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWH1Gno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWH1Gno (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 02:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWH1Gno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 02:43:44 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:27751 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932384AbWH1Gnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 02:43:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=B4Ttv4TOcWN49nczYeIhh06/MtNnexTtvm1m7IGjLx9pNvVFlj6HMr+IH+kNurazp/bVPbTRuuYsMTy8tPB29B46St0TB6+Tw52mJ54rXXwF9opSPmjhiGOKMmAcGMopYukzaE1KRz7pPExwH8CRCTKWNy/WUIcIFhA70yzLBnM=
Message-ID: <44F2902B.5050304@gmail.com>
Date: Mon, 28 Aug 2006 09:41:47 +0300
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
CC: "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com, Matt_Domsch@dell.com
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
 (ping)
References: <445B5524.2090001@gmail.com> <200608272116.23498.ak@suse.de> <44F1F356.5030105@zytor.com> <200608272254.13871.ak@suse.de> <44F21122.3030505@zytor.com> <44F286E8.1000100@gmail.com>
In-Reply-To: <44F286E8.1000100@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alon Bar-Lev wrote:
> H. Peter Anvin wrote:
>> Found the references.  This seems to imply that EDD overwrites the 
>> area used by LILO 22.6.1.  LILO 22.6.1 uses the new boot protocol, 
>> with the full pointer, and seems to obey the spec as far as I can read 
>> the code.  I'm going to try to run it in simulation and observe the 
>> failure that way.
>>
>> However, something is still seriously out of joint.  The EDD data 
>> actually overlays the setup code, not the bootsect code, and thus 
>> there "shouldn't" be any way that this could interfere.  My best guess 
>> at this time is that either the EDD code or LILO uses memory it's not 
>> supposed to use, and the simulation should hopefully reveal that.
>>
>> Sorry if I seem snarky on this, but if we can't get to the bottom of 
>> this we can't ever fix it.
>>
>>     -hpa
>>
> 
> I think I've found one problem... But I it should not be the major one.
> The EDD code scans the command-line as fixed string.
> What about something like the following?
> 
> Best Regards,
> Alon Bar-Lev.
> 
> diff -urNp linux-2.6.18-rc4-mm2/arch/i386/boot/edd.S 
> linux-2.6.18-rc4-mm2.new/arch/i386/boot/edd.S
> --- linux-2.6.18-rc4-mm2/arch/i386/boot/edd.S   2006-06-18 
> 04:49:35.000000000 +0300
> +++ linux-2.6.18-rc4-mm2.new/arch/i386/boot/edd.S       2006-08-28 
> 08:55:01.000000000 +0300
> @@ -29,6 +29,8 @@
>         movl    $(COMMAND_LINE_SIZE-7), %ecx
>  # loop through kernel command line one byte at a time
>  cl_loop:
> +       cmpb    $0,(%si)
> +       jz      done_cl
>         cmpl    $EDD_CL_EQUALS, (%si)
>         jz      found_edd_equals
>         incl    %esi
> 

Better patch.
I've noticed that this code sets esi but then reference using si... So fixed to
use esi (It worked so far since we are in low area... But I think using the same
register type is cleaner...)

Best Regards,
Alon Bar-Lev.

diff -urNp linux-2.6.18-rc4-mm2/arch/i386/boot/edd.S linux-2.6.18-rc4-mm2.new/arch/i386/boot/edd.S
--- linux-2.6.18-rc4-mm2/arch/i386/boot/edd.S   2006-06-18 04:49:35.000000000 +0300
+++ linux-2.6.18-rc4-mm2.new/arch/i386/boot/edd.S       2006-08-28 09:34:39.000000000 +0300
@@ -29,7 +29,9 @@
         movl    $(COMMAND_LINE_SIZE-7), %ecx
  # loop through kernel command line one byte at a time
  cl_loop:
-       cmpl    $EDD_CL_EQUALS, (%si)
+       cmpb    $0,(%esi)
+       jz      done_cl
+       cmpl    $EDD_CL_EQUALS, (%esi)
         jz      found_edd_equals
         incl    %esi
         loop    cl_loop
@@ -37,9 +39,9 @@ cl_loop:
  found_edd_equals:
  # only looking at first two characters after equals
         addl    $4, %esi
-       cmpw    $EDD_CL_OFF, (%si)      # edd=of
+       cmpw    $EDD_CL_OFF, (%esi)     # edd=of
         jz      do_edd_off
-       cmpw    $EDD_CL_SKIP, (%si)     # edd=sk
+       cmpw    $EDD_CL_SKIP, (%esi)    # edd=sk
         jz      do_edd_skipmbr
         jmp     done_cl
  do_edd_skipmbr:
