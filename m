Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWD3RMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWD3RMH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 13:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWD3RMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 13:12:07 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:61012 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751184AbWD3RMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 13:12:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=asrGOY4ZNjad5Sa+ZToWs/xOvlXpr6CRQmfuhudrbdaRi6OyQDJLAUxt+Cmpn47HWz/RbIQUJ/dVGxa1doFOsFxReuB2O+yS6KLm6H6XaJ2FrYengvDahNBQPfLdxDLzpC3fEMidUaJAri3ehRot9XvHiHIBN1oSkz1tdZ8OE80=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/7] uml: make copy_*_user atomic
Date: Sun, 30 Apr 2006 17:32:56 +0200
User-Agent: KMail/1.8.3
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <20060430141512.9060.39338.stgit@zion.home.lan> <20060430141614.9060.3376.stgit@zion.home.lan>
In-Reply-To: <20060430141614.9060.3376.stgit@zion.home.lan>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200604301732.59645.blaisorblade@yahoo.it>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 April 2006 16:16, Paolo 'Blaisorblade' Giarrusso wrote:
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
>
> Make __copy_*_user_inatomic really atomic to avoid "Sleeping function
> called in atomic context" warnings, especially from futex code.
>
> This is made by adding another kmap_atomic slot and making copy_*_user_skas
> use kmap_atomic; also copy_*_user() becomes atomic, but that's true and is
> not a problem for i386 (and we can always add might_sleep there as done
> elsewhere). For TT mode kmap is not used, so there's no need for this.
>
> I've had to use another slot since both KM_USER0 and KM_USER1 are used
> elsewhere and could cause conflicts. Till now we reused the kmap_atomic
> slot list from the subarch, but that's not needed as that list must contain
> the common ones (used by generic code) + the ones used in architecture
> specific code (and Uml till now used none); so I've taken the i386 one
> after comparing it with ones from other archs, and added KM_UML_USERCOPY.

> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Ok, I didn't want indeed to send this one _for merging_, even if I consider it 
correct and it indeed fixes the warnings; additionally, since HIGHMEM support 
is not very used (it's slow and less tested), there shouldn't be problems 
anyway.

Please keep it in -mm however, it should be ok and there it could get more 
exposure - and this is about interaction with the core kernel so it could get 
valid review from people outside UML.

Jeff, give a look to this one please. You need CONFIG_DEBUG_SPINLOCK_SLEEP and 
a futex user (for instance starting threaded apache inside the guest) to 
trigger the warnings.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
