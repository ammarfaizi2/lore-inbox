Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282831AbRK0HPM>; Tue, 27 Nov 2001 02:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282832AbRK0HO5>; Tue, 27 Nov 2001 02:14:57 -0500
Received: from sj1-3-1-20.iserver.com ([128.121.122.117]:59403 "EHLO
	sj1-3-1-20.iserver.com") by vger.kernel.org with ESMTP
	id <S282834AbRK0HOV>; Tue, 27 Nov 2001 02:14:21 -0500
Date: Tue, 27 Nov 2001 07:14:20 +0000
From: Nathan Myers <ncm-nospam@cantrip.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] omnibus header cleanup, certification
Message-ID: <20011127071420.A45036@cantrip.org>
Mail-Followup-To: Nathan Myers <ncm-nospam@cantrip.org>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20011127061714.A41881@cantrip.org> <3C03315C.5060203@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3C03315C.5060203@zytor.com>; from hpa@zytor.com on Mon, Nov 26, 2001 at 10:23:24PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 10:23:24PM -0800, H. Peter Anvin wrote:
> Nathan Myers wrote:
> > Please review at least the portion that you are responsible for,
> > and verify that the changes are safe and cannot change the semantics 
> > of otherwise-correct code that uses the affected macros.  (That will
> > be easy, they're all trivial parenthesizations.  It seems worth noting 
> > here that in the C grammar, "-1" is not a numeric literal, but a unary 
> > expression.) 
> 
> It's also worth noting that there is nothing that it can get confused 
> with and still have a compilable expression.

Not true, in principle.  E.g.

  #define foo -1
  ...
  char f(char* a) { return foo[a]; }  // -a[1] or a[-1]?

Such an expression should, of course, be taken out and shot (although
it's far less bad than "(x = x++ % y)" that appeared in a macro until
very recently).  

The only compound expressions that are strictly safe have one of 
the forms 

  (...)
  a.b
  a->b
  a[...]

because those are the only operators at the top precedence level.   
Even with those, an ill-defined macro that replaces "a" or "b"
(such as are found in de4x5.h) can cause confusion.
  
> I don't believe the unary-expression patches are necessary.  

One #define found in a mips header is identical to another that was in
an i386 header and already caused a bug.  That was what motivated me to 
see if there were other cases, too.  

If this patch is accepted, I will be motivated to report more subtle
sources of bugs, which remain numerous.   If we can't even be bothered
with the basics, who can care about subtleties?

> They are, 
> of course, harmless, except for the fact that my eyes glazed over 
> staring at page after page of these, which very few actual potential (!) 
> bugs (there were a couple, like the iopage+ ones...)

I assure you it was no less boring making the patch.  I hope not to 
have to keep re-making it as the existing patch rots.

The point of making a wholesale change including even "unnecessary" 
definitions that are "unlikely" to result in bugs (such as "-1"), 
is to establish a convention so that people who don't necessarily 
understand all the nuances will do the right thing anyhow.  There
is certainly plenty of code from such people in the kernel, heaven
help us.

Nathan Myers
ncm at cantrip dot org
