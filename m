Return-Path: <linux-kernel-owner+w=401wt.eu-S1751785AbXAODJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbXAODJo (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 22:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbXAODJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 22:09:44 -0500
Received: from wr-out-0506.google.com ([64.233.184.239]:10179 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbXAODJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 22:09:42 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=XEm0yRtzSn17BEH04Y3Y5vXrCi4xxar4JDMGpce08p5NVzTjhrfZSSVXmnKPPLlWjYmv/Pe7i0P9EbuGuqhuWdQUJ/AUBMXehBnUE9kkw+qbuk4j6M/ixR8qJr3QCN1knllVZFPiCJj1RdBEmaH/lKPcp3hK4R05AsCxL4pjjR4=
Message-ID: <45AAF060.3040106@gmail.com>
Date: Mon, 15 Jan 2007 12:09:20 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Proposed changes for libata speed handling
References: <20070112135301.4cdba24f@localhost.localdomain>	<45A83DD2.5020000@gmail.com> <20070113100158.1d79ba9f@localhost.localdomain>
In-Reply-To: <20070113100158.1d79ba9f@localhost.localdomain>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> O> Wouldn't it be better to have ->determine_xfer_mask() and
>> ->set_specific_mode() than having two somewhat overlapping callbacks?
>> Or is there some problem that can't be handled that way?
> 
> I'm not sure I follow what you are suggesting - can you explain further.
> 
> Right now ->set_mode does all the policy management with regards to
> picking the right modes which is sometimes done by the usual ATA rules
> and sometimes by card specific code.
> 
> ->set_specific_mode does no policy work but merely sets up a mode.
> 
> The default behaviour of ->set_mode() is the ATA mode selection by best
> mode available, and this function is normally not provided by a driver.
> 
> The default behaviour of ->set_specific_mode() is to verify the mode is
> valid then issue ->set_pio|dma_mode() (for both devices in case a timing
> change on both is triggered). This function is overridable because of
> things like IT821x where the IDE mode is imaginary.

What I was thinking about was something like the following.

* ops

	unsigned int (*determine_xfer_mask)(struct ata_device *dev);
	int (*set_specific_mode)(struct ata_device *dev,
				unsigned int xfer_mode);

* during init and EH

	if (init) {
		ap->xfer_mask &= ops->determine_xfer_mask(dev);
		DETERMINE best_mode;
	}

	if (ap->ehi.target_mode && valid)
		mode = ap->ehi.target_mode;
	else
		mode = best_mode;

	rc = ops->set_specific_mode(dev, mode);

* when the user issues SET_XFERMODE, in the issue path

	if (command is SET_XFERMODE) {
		if (mode is invalid)
			fail;
		ap->ehi.target_mode = user_specified_mode;
		ata_port_schedule_eh(ap);
		done;
	}

To sum up,

1. separate supported mode detection and mode programming such that we
can use the same programming path for both init and handling user-issued
SET_XFERMODE.

2. group all mode programming callbacks (->set_piomode, ->set_dmamode
and ->post_set_mode into ->set_specific_mode) into ->set_specific_mode
to allow more flexibility and replace ->set_mode.

3. make sure all xfer mode programming is done in EH.  this will ease
support for weird controllers (e.g. cross-port synchronization).

Thanks.

-- 
tejun
