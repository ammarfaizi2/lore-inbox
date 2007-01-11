Return-Path: <linux-kernel-owner+w=401wt.eu-S932813AbXAKXhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932813AbXAKXhW (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 18:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932818AbXAKXhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 18:37:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:3270 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932177AbXAKXhU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 18:37:20 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ULRQwQ/n2B+q8B5Te4GStCot7kcMGGln/lJ6GkHgIUjh9fpsK5GTDsmCnE6Glqt1qZ+v3J31B2HvJ7q2HERIJk6pF0qtpp1EuOw+qNRFnoYzhy31JmTtCEuM+AafV3gC+a7OZIFk9B0KmbPteO/nmRNlzW2RZ5hTmm7G9tcnfeo=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Benny Halevy <bhalevy@panasas.com>
Subject: Re: Finding hardlinks
Date: Fri, 12 Jan 2007 00:35:37 +0100
User-Agent: KMail/1.8.2
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Arjan van de Ven <arjan@infradead.org>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@ietf.org
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz> <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz> <4593890C.8030207@panasas.com>
In-Reply-To: <4593890C.8030207@panasas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701120035.37337.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 December 2006 10:06, Benny Halevy wrote:
> Mikulas Patocka wrote:
> >>> If user (or script) doesn't specify that flag, it doesn't help. I think
> >>> the best solution for these filesystems would be either to add new syscall
> >>>  	int is_hardlink(char *filename1, char *filename2)
> >>> (but I know adding syscall bloat may be objectionable)
> >> it's also the wrong api; the filenames may have been changed under you
> >> just as you return from this call, so it really is a
> >> "was_hardlink_at_some_point()" as you specify it.
> >> If you make it work on fd's.. it has a chance at least.
> > 
> > Yes, but it doesn't matter --- if the tree changes under "cp -a" command, 
> > no one guarantees you what you get.
> >  	int fis_hardlink(int handle1, int handle 2);
> > Is another possibility but it can't detect hardlinked symlinks.

It also suffers from combinatorial explosion.
cp -a on 10^6 files will require ~0.5 * 10^12 compares...
 
> It seems like the posix idea of unique <st_dev, st_ino> doesn't
> hold water for modern file systems and that creates real problems for
> backup apps which rely on that to detect hard links.

Yes, and it should have been obvious at 32->64bit inode# transition.
Unfortunately people tend to think "ok, NOW this new shiny BIGNUM-bit
field is big enough for everybody". Then cycle repeats in five years...

I think the solution is that inode "numbers" should become
opaque _variable-length_ hashes. They are already just hash values,
this is nothing new. All problems stem from fixed width of inode# only.

--
vda
