Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275311AbTHMR55 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 13:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275303AbTHMR55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 13:57:57 -0400
Received: from fw1.masirv.com ([65.205.206.2]:58218 "EHLO NEWMAN.masirv.com")
	by vger.kernel.org with ESMTP id S275311AbTHMR5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 13:57:37 -0400
Message-ID: <1060744140.15792.17.camel@huykhoi>
From: Anthony Truong <Anthony.Truong@mascorp.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>, andersen@codepoet.org,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       bernd@firmix.at, alan@lxorguk.ukuu.org.uk, schwab@suse.de,
       ysato@users.sourceforge.jp, Valdis.Kletnieks@vt.edu,
       william.gallafent@virgin.net
Subject: Re: generic strncpy - off-by-one error
Date: Tue, 12 Aug 2003 20:09:00 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-13 at 13:18, Willy Tarreau wrote:

On Tue, Aug 12, 2003 at 11:38:31PM -0400, Albert Cahalan wrote:
> That's excellent. On ppc I count 12 instructions,
> 4 of which would go away for typical usage if inlined.
> Annoyingly, gcc doesn't get the same assembly from my
> attempt at that general idea:
> 
> char * strncpy_5(char *dest, const char *src, size_t count){
>   char *tmp = dest;
>   while (count--){
>     if(( *tmp++ = *src )) src++;
>   }
>   return dest;
> }
> 
> I suppose that gcc could use a bug report.

I often noticed that using '++' and '--' within or just before
assignments
and/or comparisons often break the code and make it suboptimal. C
provides
enough flexibility to code what you think nearly at the instruction
level.
Since 'while' loops often start with a jump to the end, you can
sometimes help
the compiler by enclosing them within an 'if' statement such as below.
BTW, in
your case, count ends with -1.

I've absolutely not tried this one, but it could produce different code
on your
PPC, and can trivially be derived to cleaner constructs. I proceeded the
same
way when I wrote my own optimized strlcpy() implementation which is 45
bytes
long and copies 1 char per CPU cycle on i686.

char *strncpy(char *dest, const char *src, size_t count)
{
   if (count) {
      char *tmp = dest;
      while (1) {
         *tmp = *src;
         if (*src) src++;
         tmp++;
         if (!count--) break;
      }
   }
   return dest;
}

Cheers,
Willy


Hello,
This reminds me of my days in school learning how to program in C/C++. 
I first learnt that in
  while (count-- && (*dest++ = *src++));
  the first operand of && will be evaluated first, and then the second
  iff the first is evaluated to TRUE.
  count-- : count will be checked to see if it is not 0 first, and if it
  is not, it will get decremented.  If it is, the while loop is ended.
  Therefore, how could count go to -1?
If there is a bug in the gcc, then should we fix it rather than messing 
with our coding trying to please it?
We don't have to do if (count) before the loop because a count of 0 is 
already caught in while (count-- ......).

Again, maybe what I learnt in school about C/C++ programming is all
wrong.:-)

:-)
Anthony Dominic Truong.




Disclaimer: The information contained in this transmission, including any
attachments, may contain confidential information of Matsushita Avionics
Systems Corporation.  This transmission is intended only for the use of the
addressee(s) listed above.  Unauthorized review, dissemination or other use
of the information contained in this transmission is strictly prohibited.
If you have received this transmission in error or have reason to believe
you are not authorized to receive it, please notify the sender by return
email and promptly delete the transmission.


