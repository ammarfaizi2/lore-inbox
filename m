Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132540AbREBKZU>; Wed, 2 May 2001 06:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132553AbREBKZB>; Wed, 2 May 2001 06:25:01 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:15672 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S132540AbREBKYm>; Wed, 2 May 2001 06:24:42 -0400
Date: Tue, 1 May 2001 17:35:58 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "J . A . Magallon" <jamagallon@able.es>,
        Wakko Warner <wakko@animx.eu.org>,
        Xavier Bestel <xavier.bestel@free.fr>,
        Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>,
        William T Wilson <fluffy@snurgle.org>, Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2GB swap partition limit
Message-ID: <20010501173558.U26638@redhat.com>
In-Reply-To: <20010501140003.A28747@redhat.com> <200105011614.SAA03338@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200105011614.SAA03338@cave.bitwizard.nl>; from R.E.Wolff@BitWizard.nl on Tue, May 01, 2001 at 06:14:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 01, 2001 at 06:14:54PM +0200, Rogier Wolff wrote:

> Shouldn't the algorithm be: 
> 
> - If (current_access == write )
> 	free (swap_page);
>   else
>  	map (page, READONLY)
> 
> and 
>   when a write access happens, we fault again, and map free the 
>   swap-page as it is now dirty anyway. 

That's what 2.2 did.  2.4 doesn't have to. 

The trouble is, you really want contiguous virtual memory to remain
contiguous on swap.  Freeing individual pages like this on fault can
cause a great deal of fragmentation in swap.  We'd far rather keep the
swap page reserved for future use by the same page so that the VM
region remains contiguous on disk.

That's fine as far as it goes, but the problem happens if you _never_
free up such pages.  We should reap the unused swap page if we run out
of swap.  We don't, and _that_ is the problem --- not the fact that
the page is left allocated in the first place, but the fact that we
don't do anything about it once we are short on disk.

--Stephen
