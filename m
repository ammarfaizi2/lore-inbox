Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267628AbUHPNGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267628AbUHPNGX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 09:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267609AbUHPNFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 09:05:49 -0400
Received: from mail.timesys.com ([65.117.135.102]:16425 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S267599AbUHPNCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 09:02:21 -0400
Message-ID: <4120B055.8090503@timesys.com>
Date: Mon, 16 Aug 2004 09:02:13 -0400
From: Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Dan Malek <dan@embeddededge.com>, Kumar Gala <kumar.gala@freescale.com>,
       LKML <linux-kernel@vger.kernel.org>,
       LinuxPPC-dev Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [BUG] PPC math-emu multiply problem
References: <4108F845.7080305@timesys.com> <85C49799-E168-11D8-B0AC-000393DBC2E8@freescale.com> <A46787F8-E194-11D8-B8DB-003065F9B7DC@embeddededge.com> <410A5F08.90103@timesys.com> <410A67EA.80705@timesys.com> <20040809165650.GA22109@smtp.west.cox.net> <6FBD1B21-EA2B-11D8-8382-003065F9B7DC@embeddededge.com> <20040809222328.GB22109@smtp.west.cox.net>
In-Reply-To: <20040809222328.GB22109@smtp.west.cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Aug 2004 13:00:52.0375 (UTC) FILETIME=[0F521270:01C48391]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:

>On Mon, Aug 09, 2004 at 01:42:08PM -0400, Dan Malek wrote:
>
>  
>
>>On Aug 9, 2004, at 12:56 PM, Tom Rini wrote:
>>
>>    
>>
>>>Has anyone had a problem with this?  If not, I'll go and pass it
>>>along...
>>>      
>>>
>>The default rounding mode should be whatever is defined
>>by IEEE.  I thought the emulator used the proper default value
>>and if want something different it should be selected by
>>the control register.  Maybe the emulator isn't implementing
>>the control register properly.
>>    
>>
>
>Or we had the wrong default?  Greg, any chance you've looked into this
>more?  Thanks.
>
>  
>
I'm back.

The round mode for the emulator is compiled in. Changing the round mode 
caused failures in some of the other LSB float tests.  I had intended to 
say something about this before taking off on vacation. Sorry.

The way I got the LSB tests to pass was to remove the round in the 
denormalised underflow case. This appears to match the hardware 
behavior. I've not looked at the PPC floating point model close enough 
to know if this is proper behavior. It is what the LSB tests are 
expecting and doesn't cause a failure in any of the other LSB tests.

Greg Weeks

Signed-off-by: Greg Weeks <greg.weeks@timesys.com> under TS0087


--- ppc-mpc8560ads-cgl/arch/ppc/math-emu/op-common.h.orig       
2004-08-16 08:56:07.000000000 -0400
+++ ppc-mpc8560ads-cgl/arch/ppc/math-emu/op-common.h    2004-08-04 
10:04:45.000000000 -0400
@@ -82,7 +82,6 @@ do {
        \
        if (X##_e <= _FP_WFRACBITS_##fs)                        \
          {                                                     \
            _FP_FRAC_SRS_##wc(X, X##_e, _FP_WFRACBITS_##fs);    \
-           __ret |= _FP_ROUND(wc, X);                          \
            _FP_FRAC_SLL_##wc(X, 1);                            \
            if (_FP_FRAC_OVERP_##wc(fs, X))                     \
              {                                                 \

