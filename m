Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVDMWan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVDMWan (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 18:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVDMWan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 18:30:43 -0400
Received: from hermes.domdv.de ([193.102.202.1]:38664 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261159AbVDMWag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 18:30:36 -0400
Message-ID: <425D9D50.9050507@domdv.de>
Date: Thu, 14 Apr 2005 00:29:36 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: rjw@sisk.pl, pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
References: <E1DLgWi-0003Ag-00@gondolin.me.apana.org.au> <425D17B0.8070109@domdv.de> <20050413212731.GA27091@gondor.apana.org.au>
In-Reply-To: <20050413212731.GA27091@gondor.apana.org.au>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> On Wed, Apr 13, 2005 at 02:59:28PM +0200, Andreas Steinmetz wrote:
> 
>>Herbert Xu wrote:
>>
>>>What's wrong with using swap over dmcrypt + initramfs? People have
>>>already used that to do encrypted swsusp.
>>
>>Nothing. The problem is the fact that after resume there is then
>>unencrypted(*) data on disk that should never have been there, e.g.
>>dm-crypt keys, ssh keys, ...
> 
> 
> Why is that? In the case of swap over dmcrypt, swsusp never reads/writes
> the disk directly.  All operations are done through dmcrypt.
> 
> The user has to enter a password before the system can be resumed.

Think of it the following way: user suspend and later resumes. During
suspend some mlocked memory e.g. from ssh-agent gets dumped to swap.
Some days later the system gets broken in from a remote place.
Unfortunately the ssh keys are still on swap (assuming that ssh-agent is
not running then) and can be recovered by the intruder. The intruder can
then gain access to other sites with the data recovered from the earlier
suspend.

You see, it is not a matter of having encrypted swap, what matters here
is what suspend needs to write to swap and this can be stuff that does
not belong there so it needs to be erased after resume. And the easiest
way to do this is to encrypt the suspend image with a temporary key that
gets cleared on resume.

If you don't resume mkswap will also clear the key though i have to
admit that there's a small window then in which the key and data are
still accessible.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
