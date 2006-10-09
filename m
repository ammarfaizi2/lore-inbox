Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbWJJCKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWJJCKH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 22:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWJJCJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 22:09:43 -0400
Received: from [198.99.130.12] ([198.99.130.12]:47077 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751909AbWJJCJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 22:09:40 -0400
Date: Mon, 9 Oct 2006 14:00:13 -0400
From: Jeff Dike <jdike@addtoit.com>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 06/14] uml: make UML_SETJMP always safe
Message-ID: <20061009180013.GB4931@ccure.user-mode-linux.org>
References: <20061005213212.17268.7409.stgit@memento.home.lan> <20061005213852.17268.13871.stgit@memento.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061005213852.17268.13871.stgit@memento.home.lan>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 11:38:52PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> If enable is moved by GCC in a register its value may not be preserved after
> coming back there with longjmp(). So, mark it as volatile to prevent this; this
> is suggested (it seems) in info gcc, when it talks about -Wuninitialized. I
> re-read this and it seems to say something different, but I still believe this
> may be needed.
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> ---
> 
>  arch/um/include/longjmp.h |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/um/include/longjmp.h b/arch/um/include/longjmp.h
> index e93c6d3..e860bc5 100644
> --- a/arch/um/include/longjmp.h
> +++ b/arch/um/include/longjmp.h
> @@ -12,7 +12,8 @@ #define UML_LONGJMP(buf, val) do { \
>  } while(0)
>  
>  #define UML_SETJMP(buf) ({ \
> -	int n, enable;	   \
> +	int n;	   \
> +	volatile int enable;	\
>  	enable = get_signals(); \
>  	n = setjmp(*buf); \
>  	if(n != 0) \

I agree with this, but not entirely with your reasoning.  The
-Wuninitialized documentation just talks about when gcc emits a
warning.

What we want is a guarantee that enable is not cached in a register,
but is stored in memory.  What documentation I can find seems to imply
that is the case ("accesses to volatile objects must have settled
before the next sequence point").

However, given the prevailing opinion that essentially all volatile
declarations are hiding bugs, I wouldn't mind a bit of review of this
from someone holding this opinion.

				Jeff
