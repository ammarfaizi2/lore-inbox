Return-Path: <linux-kernel-owner+w=401wt.eu-S1762710AbWLKKER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762710AbWLKKER (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 05:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762711AbWLKKEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 05:04:16 -0500
Received: from nz-out-0506.google.com ([64.233.162.226]:17303 "EHLO
	nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762710AbWLKKEP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 05:04:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=usRAat1T5aekrPfb+GlWG1ffuywDLMjTCr35WXXpstxOMSSVlD2lRMgx+CVNo3e8lpZP3w5BrvH3ta+PSefg3t1mmpd9HVIsS8NTjJ4dj+u0mff76SLIYApbDFLMExYukXCsiSnOFpMeQQFZujHxiKJEjbT7tCGRoEAK0QuSUA8=
Message-ID: <5d96567b0612110204w10bd9029v1305495cd1628a6b@mail.gmail.com>
Date: Mon, 11 Dec 2006 12:04:14 +0200
From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
To: "Jens Axboe" <jens.axboe@oracle.com>
Subject: Re: [patch 63/87] md: define raid5_mergeable_bvec
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <20061211090301.GH4576@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_62198_31417396.1165831454924"
References: <200612101020.kBAAKjJB021309@shell0.pdx.osdl.net>
	 <20061211074825.GA4576@kernel.dk>
	 <5d96567b0612110054u7e4bd628xc217c04ab6835d5f@mail.gmail.com>
	 <20061211090301.GH4576@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_62198_31417396.1165831454924
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

this is against 2.6.19-git17
hope this correct
raz

On 12/11/06, Jens Axboe <jens.axboe@oracle.com> wrote:
> On Mon, Dec 11 2006, Raz Ben-Jehuda(caro) wrote:
> > On 12/11/06, Jens Axboe <jens.axboe@oracle.com> wrote:
> > >On Sun, Dec 10 2006, akpm@osdl.org wrote:
> > >> From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
> > >>
> > >> This will encourage read request to be on only one device, so we will
> > >often be
> > >> able to bypass the cache for read requests.
> > >>
> > >> Signed-off-by: Neil Brown <neilb@suse.de>
> > >> Cc: Jens Axboe <jens.axboe@oracle.com>
> > >> Signed-off-by: Andrew Morton <akpm@osdl.org>
> > >> ---
> > >>
> > >>  drivers/md/raid5.c |   24 ++++++++++++++++++++++++
> > >>  1 file changed, 24 insertions(+)
> > >>
> > >> diff -puN drivers/md/raid5.c~md-define-raid5_mergeable_bvec
> > >drivers/md/raid5.c
> > >> --- a/drivers/md/raid5.c~md-define-raid5_mergeable_bvec
> > >> +++ a/drivers/md/raid5.c
> > >> @@ -2611,6 +2611,28 @@ static int raid5_congested(void *data, i
> > >>       return 0;
> > >>  }
> > >>
> > >> +/* We want read requests to align with chunks where possible,
> > >> + * but write requests don't need to.
> > >> + */
> > >> +static int raid5_mergeable_bvec(request_queue_t *q, struct bio *bio,
> > >struct bio_vec *biovec)
> > >> +{
> > >> +     mddev_t *mddev = q->queuedata;
> > >> +     sector_t sector = bio->bi_sector + get_start_sect(bio->bi_bdev);
> > >> +     int max;
> > >> +     unsigned int chunk_sectors = mddev->chunk_size >> 9;
> > >> +     unsigned int bio_sectors = bio->bi_size >> 9;
> > >> +
> > >> +     if (bio_data_dir(bio))
> > >> +             return biovec->bv_len; /* always allow writes to be
> > >mergeable */
> > >
> > >Please don't ever do that - you are making assumptions on the value of
> > >READ and WRITE.
> > >
> > >        if (bio_data_dir(bio) == WRITE)
> > >                ...
> > >
> > >If this has already been merged, please submit a patch correcting it.
> > >People end up copying code like this :-)
> > >
> > >--
> > >Jens Axboe
> > >
> > >
> >
> > thanks Jens
> > the attached is a fix.
>
> But the patch is already merged, so the patch needs to be against Linus'
> current tree.
>
> --
> Jens Axboe
>
>


-- 
Raz

------=_Part_62198_31417396.1165831454924
Content-Type: text/x-patch; name=mergeablevecJens.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_evkpvnbu
Content-Disposition: attachment; filename="mergeablevecJens.patch"

LS0tIGxpbnV4LTIuNi4xOS9kcml2ZXJzL21kL3JhaWQ1LmMJMjAwNi0xMi0xMSAxMTozMzoyMy4w
MDAwMDAwMDAgKzAwMDAKKysrIGxpbnV4LTIuNi4xOS1naXQxNy9kcml2ZXJzL21kL3JhaWQ1LmMJ
MjAwNi0xMi0xMSAxMTozMToyNy4wMDAwMDAwMDAgKzAwMDAKQEAgLTI1NjcsNyArMjU2Nyw3IEBA
CiAJdW5zaWduZWQgaW50IGNodW5rX3NlY3RvcnMgPSBtZGRldi0+Y2h1bmtfc2l6ZSA+PiA5Owog
CXVuc2lnbmVkIGludCBiaW9fc2VjdG9ycyA9IGJpby0+Ymlfc2l6ZSA+PiA5OwogCi0JaWYgKGJp
b19kYXRhX2RpcihiaW8pKQorCWlmIChiaW9fZGF0YV9kaXIoYmlvKSA9PSBXUklURSApCiAJCXJl
dHVybiBiaW92ZWMtPmJ2X2xlbjsgLyogYWx3YXlzIGFsbG93IHdyaXRlcyB0byBiZSBtZXJnZWFi
bGUgKi8KIAogCW1heCA9ICAoY2h1bmtfc2VjdG9ycyAtICgoc2VjdG9yICYgKGNodW5rX3NlY3Rv
cnMgLSAxKSkgKyBiaW9fc2VjdG9ycykpIDw8IDk7Cg==
------=_Part_62198_31417396.1165831454924--
