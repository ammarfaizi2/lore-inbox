Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262212AbVDFOQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbVDFOQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 10:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbVDFOQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 10:16:27 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:1160 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262212AbVDFOQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 10:16:21 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-os@analogic.com, Dave Korn <dave.korn@artimi.com>
Subject: Re: [BUG mm] "fixed" i386 memcpy inlining buggy
Date: Wed, 6 Apr 2005 17:16:07 +0300
User-Agent: KMail/1.5.4
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>,
       Jan Hubicka <hubicka@ucw.cz>, Gerold Jury <gerold.ml@inode.at>,
       jakub@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       gcc@gcc.gnu.org
References: <SERRANOEKRuYDlrjbud0000007e@SERRANO.CAM.ARTIMI.COM> <Pine.LNX.4.61.0504060912420.22100@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0504060912420.22100@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504061716.07895.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 April 2005 16:18, Richard B. Johnson wrote:
> 
> Attached is inline ix86 memcpy() plus test code that tests its
> corner-cases. The in-line code makes no jumps, but uses longword
> copies, word copies and any spare byte copy. It works at all
> offsets, doesn't require alignment but would work fastest if
> both source and destination were longword aligned.

Yours is:

        "shr $1, %%ecx\n"       \
        "pushf\n"               \
        "shr $1, %%ecx\n"       \
        "pushf\n"               \   <=== not needed
        "rep\n"                 \
        "movsl\n"               \
        "popf\n"                \   <=== not needed
        "adcl %%ecx, %%ecx\n"   \
        "rep\n"                 \
        "movsw\n"               \
        "popf\n"                \
        "adcl %%ecx, %%ecx\n"   \
        "rep\n"                 \
        "movsb\n"               \

You struggle too much for that movsw.

-mm one (which happen to be mine) is:

	"movl %ecx,%4"
	"shr $2,%ecx"
        "rep ; movsl"
        "movl %4,%%ecx"
        "andl $3,%%ecx"
        "jz 1ft"     /* pay 2 byte penalty for a chance to skip microcoded rep */
        "rep ; movsb"
"1:"

and I can still drop that jz. It is there just to have
a chance to skip rep movsb, it was measured to be slow
enough to matter. rep movs are a bit slow to start, on small
blocks it is measurable.

However, maybe it is even better without jz,
need to benchmark 'cold path' (i.e. where branch predictor
have no data to predict it) somehow.
--
vda

