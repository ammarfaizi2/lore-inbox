Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271390AbTHMFTI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 01:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271391AbTHMFTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 01:19:08 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:19985 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S271390AbTHMFTE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 01:19:04 -0400
Date: Wed, 13 Aug 2003 07:18:19 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: andersen@codepoet.org, Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       bernd@firmix.at, Anthony.Truong@mascorp.com, alan@lxorguk.ukuu.org.uk,
       schwab@suse.de, ysato@users.sourceforge.jp, willy@w.ods.org,
       Valdis.Kletnieks@vt.edu, william.gallafent@virgin.net
Subject: Re: generic strncpy - off-by-one error
Message-ID: <20030813051819.GA28323@alpha.home.local>
References: <1060741101.948.245.camel@cube> <20030813024752.GA20369@codepoet.org> <1060745910.948.268.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060745910.948.268.camel@cube>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

I often noticed that using '++' and '--' within or just before assignments
and/or comparisons often break the code and make it suboptimal. C provides
enough flexibility to code what you think nearly at the instruction level.
Since 'while' loops often start with a jump to the end, you can sometimes help
the compiler by enclosing them within an 'if' statement such as below. BTW, in
your case, count ends with -1.

I've absolutely not tried this one, but it could produce different code on your
PPC, and can trivially be derived to cleaner constructs. I proceeded the same
way when I wrote my own optimized strlcpy() implementation which is 45 bytes
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

