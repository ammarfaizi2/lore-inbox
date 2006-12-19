Return-Path: <linux-kernel-owner+w=401wt.eu-S932987AbWLSXcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932987AbWLSXcm (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 18:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932989AbWLSXcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 18:32:42 -0500
Received: from web31811.mail.mud.yahoo.com ([68.142.207.74]:35296 "HELO
	web31811.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932986AbWLSXcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 18:32:41 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 18:32:41 EST
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=DpzMLTO/ONYUYX34jT+IoyDLKmoGryoVSvn9SDXc+P/Al6PXZ1xOtaA8ZC7gQRNertgOZf3lJB1Ow9+X+jHe4wWermk7kG1b1h2lP9THdWnzdKu+1fp3aL9zonUHxu0mqEGMqnSQ8rpO+PYX3Cer0qdX4/3lhBdRuctQDCgQ7lY=;
X-YMail-OSG: pxoBqAsVM1mTuxVVJpUEGNDyewVx5GIfhZKoU_ah523T1ryoIRsEtg.DKGHyd0gJb6DjqEttyYspQsTHTzn6ln4ROTyH7u8HyKxUfPXcx4DfN6zAJ4hMM_SQfto2vlI00EAxmuwELWiAmrXI6k1Ja8JjUKAmxQ--
Date: Tue, 19 Dec 2006 15:26:00 -0800 (PST)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: sata badness in 2.6.20-rc1? [Was: Re: md patches in -mm]
To: Jurriaan <thunder7@xs4all.nl>, Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Jeff Garzik <jeff@garzik.org>,
       Neil Brown <neilb@suse.de>, Jurriaan <thunder7@xs4all.nl>,
       linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       Tejun Heo <htejun@gmail.com>, Alan <alan@lxorguk.ukuu.org.uk>,
       Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <20061217160056.GA3555@amd64.of.nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <362582.18476.qm@web31811.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- thunder7@xs4all.nl wrote:
> From: Andrew Morton <akpm@osdl.org>
> Date: Sun, Dec 17, 2006 at 03:05:39AM -0800
> > On Sun, 17 Dec 2006 12:00:12 +0100
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > 
> > > Okay, I have identified the patch that causes the problem to appear, which is
> > > 
> > > fix-sense-key-medium-error-processing-and-retry.patch
> > > 
> > > With this patch reverted -rc1-mm1 is happily running on my test box.
> > 
> > That was rather unexpected.   Thanks.
> >
> I can confirm that 2.6.20-rc1-mm1 with this patch reverted mounts my
> raid6 partition without problems. This is x86_64 with SMP.
> 

The reason was that my dev tree was tainted by this bug:

        if (good_bytes &&
-           scsi_end_request(cmd, 1, good_bytes, !!result) == NULL)
+           scsi_end_request(cmd, 1, good_bytes, result == 0) == NULL)
                return;

in scsi_io_completion().  I had there !!result which is wrong, and when
I diffed against master, it produced a bad patch.

As James mentioned one of the chunks is good and can go in.

    Luben

