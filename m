Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275725AbRI0BAn>; Wed, 26 Sep 2001 21:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275727AbRI0BAe>; Wed, 26 Sep 2001 21:00:34 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:4839 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S275725AbRI0BAQ>; Wed, 26 Sep 2001 21:00:16 -0400
Message-ID: <13FCCC1F3509D411B1C700A0C969DEBB05E20911@fmsmsx91.fm.intel.com>
From: "Gonzalez, Inaky" <inaky.gonzalez@intel.com>
To: linux-kernel@vger.kernel.org
Subject: POSSIBLE BUG: 2.4.10 drivers/char/raw.c: Need help of maintainer/
	guru
Date: Wed, 26 Sep 2001 18:00:39 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hi

	I was going trough some usage patterns of brw_kiovec()
when I came across the main loop in dev.c:rw_raw_dev(). In 
this loop, brw_kiovec() is called and the error code used 
as bytes read or error detector [see at bottom].

	However, if there is an error, err != iosize and the loop
will break. But it could happpen that the transferred variable
has been already set to something !0 (ie: in the second or 
subsequent loop cycles), so the check in 371 is going to reset
err to a non-error value and return, thus the error is not
going to proagate up.

	I just want to make sure, I don't know if this is a bug
or a feature ...

	TIA

354                 err = brw_kiovec(rw, 1, &iobuf, dev, iobuf->blocks,
sector_size);
355 
356                 if (rw == READ && err > 0)
357                         mark_dirty_kiobuf(iobuf, err);
358                 
359                 if (err >= 0) {
360                         transferred += err;
361                         size -= err;
362                         buf += err;
363                 }
364 
365                 unmap_kiobuf(iobuf);
366 
367                 if (err != iosize)
368                         break;
369         }
370         
371         if (transferred) {
372                 *offp += transferred;
373                 err = transferred;
374         }
375 
376  out_free:
377         if (!new_iobuf)
378                 clear_bit(0, &filp->f_iobuf_lock);
379         else
380                 free_kiovec(1, &iobuf);
381  out:   
382         return err;
383 }
384 
