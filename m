Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932628AbVKXKOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628AbVKXKOu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 05:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932629AbVKXKOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 05:14:50 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:57398 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932628AbVKXKOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 05:14:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=UVEawQIss7WDo2YcTYdDYt+6fgi9+itnp5jAbPRKOZZeDTjWtbRI7r2Ma8iWsNZAka4aifD2D6BG59mCr9eCEwsjiSuT5Mb3DElo75gwbO/z+D9hPx9U+SCva4qoT6VM2HkfgjSMV0O5jq1YuWL1XbyL1UMlI9wtQ5v2I5YGdVo=
Message-ID: <4385925F.8010108@gmail.com>
Date: Thu, 24 Nov 2005 18:13:51 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: Console rotation problems
References: <1132793150.26560.357.camel@gaston>  <1132793556.26560.361.camel@gaston> <1132796831.26560.392.camel@gaston> <1132801542.26560.402.camel@gaston> <43855DBA.1050302@gmail.com> <Pine.LNX.4.62.0511241042360.6400@numbat.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0511241042360.6400@numbat.sonytel.be>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
> On Thu, 24 Nov 2005, Antonino A. Daplas wrote:
>> Benjamin Herrenschmidt wrote:
>>> Remove bogus usage of test/set_bit() from fbcon rotation code and just
>>> manipulate the bits directly. This fixes an oops on powerpc among others
>>> and should be faster. Seems to work fine on the G5 here.
>> Thanks, I reached a point when my head became muddled with bit 
>> manipulations, so I used arch-specific bitops but complete forgot
>> that they were atomic :-)
> 
> I haven't really looked at the rotation code, but I guess it can be optimized a
> lot by using similar techniques like c2p (chunky-to-planar) conversions.
> 

Actually, BenH's patch touched code that is in the slow path.  The font
rotation is done on the entire fontdata, then stored, on a console switch.
Thus the rest of the drawing functions need not do repetitive and expensive
bitmap rotation.

Scrolling performance of a normally oriented and upside-down rotation is
practically the same (1024x768 8x16 redraw).

con_rotate = 0
real    0m2.550s
user    0m0.000s
sys     0m2.543s

con_rotate = 2
real    0m2.559s
user    0m0.001s
sys     0m2.545s


CCW and CW rotation, is of course slower, because the blit direction
tends to be top->down, rather than left->right.

con_rotate = 1
real    0m4.675s
user    0m0.000s
sys     0m4.663s

con_rotate = 3
real    0m4.701s
user    0m0.001s
sys     0m4.684s
  
Tony
