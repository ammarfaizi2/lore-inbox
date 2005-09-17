Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbVIQGpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbVIQGpH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 02:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbVIQGpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 02:45:07 -0400
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:50378 "EHLO
	smtprelay04.ispgateway.de") by vger.kernel.org with ESMTP
	id S1750970AbVIQGpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 02:45:06 -0400
Message-ID: <432BBB6D.4060006@v.loewis.de>
Date: Sat, 17 Sep 2005 08:45:01 +0200
From: =?ISO-8859-1?Q?=22Martin_v=2E_L=F6wis=22?= <martin@v.loewis.de>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: 7eggert@gmx.de
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
References: <4NsP0-3YF-11@gated-at.bofh.it> <4NsP0-3YF-13@gated-at.bofh.it> <4NsP0-3YF-15@gated-at.bofh.it> <4NsP0-3YF-17@gated-at.bofh.it> <4NsP1-3YF-19@gated-at.bofh.it> <4NsP1-3YF-21@gated-at.bofh.it> <4NsOZ-3YF-9@gated-at.bofh.it>
In-Reply-To: <4NsOZ-3YF-9@gated-at.bofh.it>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert wrote:
> BTW2: However, I don't like the patch.
> 
> I'd first check for a utf-8 signature, and if it's found, adjust the
> buffer offset by 3. Then I'd run the old code checking for the sh_bang.
> OTOH, I just read the patch and not the .c file, maybe (unlikely) my idea
> wouldn't work correctly.

I believe this wouldn't work. binfmt_script currently has the code

        for (cp = bprm->buf+2; (*cp == ' ') || (*cp == '\t'); cp++);

to get out the (start of the) interpreter file name. This knows
implicitly that you need to skip two bytes #!; for UTF-8 signatures,
it would be 5 bytes.

Now, if you meant to suggest that bprm->buf should be adjusted (e.g.
through 'brpm->buf += 3'): this cannot work, either. It would break
subsequent binfmt modules which assume that bprm->buf is the first
1KiB (or so) of the file to be executed.

If you suggest that the patch should merely check for the signature,
and then skip it: this is what the patch does.

Regards,
Martin

P.S. I just noticed there is a

bprm->buf[BINPRM_BUF_SIZE - 1] = '\0';

which seems incorrect: it puts a null-byte into the buffer data,
thus (slightly) corrupting the data for subsequent binfmt modules
(although it already knows the file starts with #!, so the
 subsequent modules will fail, anyway)

Also, I think the above loop should also terminate for '

 *cp == '\0'

if there is neither a space nor a tab in the file.
