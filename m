Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWDEJBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWDEJBX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 05:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWDEJBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 05:01:23 -0400
Received: from mail.gondor.com ([212.117.64.182]:42756 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S1751181AbWDEJBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 05:01:23 -0400
Date: Wed, 5 Apr 2006 11:01:17 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Ken Moffat <zarniwhoop@ntlworld.com>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] Slab corruptions & Re: 2.6.17-rc1: Oops in sound applications
Message-ID: <20060405090117.GB4794@knautsch.gondor.com>
References: <Pine.LNX.4.63.0604032155220.17605@deepthought.mydomain> <20060404133814.GA11741@knautsch.gondor.com> <s5hlkul72rv.wl%tiwai@suse.de> <20060404190631.GA4895@knautsch.gondor.com> <s5h7j656tpp.wl%tiwai@suse.de> <20060404231911.GA4862@knautsch.gondor.com> <20060405002846.GA5201@knautsch.gondor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060405002846.GA5201@knautsch.gondor.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2006 at 02:28:47AM +0200, Jan Niehusmann wrote:
> If I now add the patch you suggested, correcting the check in
> snd_pcm_oss_open_file(), accessing /dev/dsp instead leads to EINVAL.
> 
> So I guess git bisect really lead me to this already known bug.

And another update. Sorry for sending so many small mails, but I want to
keep you informed to avoid unnecessary duplication of work.

To make sure I didn't do something stupid like confusing kernel
versions, I retried with 2.6.17-rc1 and the mentioned patch. It oopses
again, but the behaviour is different:

Versions 2.6.16 to commit bf1bbb5a49eec51c30d341606885507b501b37e8 only
allow a single open of /dev/dsp, and do not oops.

Commit 3bf75f9b90c981f18f27a0d35a44f488ab68c8ea and later do oops with
commands as simple as 'yes >/dev/dsp'.

Commit 3bf75f9b90c981f18f27a0d35a44f488ab68c8ea with the patch to
snd_pcm_oss_open_file() applied do not oops, but block every access to
/dev/dsp with EINVAL.

2.6.17-rc1 with the patch to snd_pcm_oss_open_file(), again, allows
opening of /dev/dsp, 'yes >/dev/dsp' does work as expected, but for
example twinkle (a VoIP application) gives garbled sound. Additionally,
I am now able to open /dev/dsp a second time (eg. 'yes >/dev/dsp' while
twinkle uses the sound device), immediately leading to an oops.

My guess is that this bug is just not triggered in commit
3bf75f9b90c981f18f27a0d35a44f488ab68c8ea because, for some other reason,
/dev/dsp is completely unusable.

Jan

