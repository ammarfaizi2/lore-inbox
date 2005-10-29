Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbVJ2Fzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbVJ2Fzt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 01:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbVJ2Fzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 01:55:48 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:43516 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751355AbVJ2Fzs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 01:55:48 -0400
Message-ID: <43630FDA.7010101@student.ltu.se>
Date: Sat, 29 Oct 2005 07:59:54 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: arnd@arndb.de, davej@redhat.com, kaos@ocs.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14 assorted warnings
References: <5455.1130484079@kao2.melbourne.sgi.com> <20051028073049.GA27389@redhat.com> <200510281007.42758.arnd@arndb.de> <20051028082944.GI11441@suse.de>
In-Reply-To: <20051028082944.GI11441@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>On Fri, Oct 28 2005, Arnd Bergmann wrote:
>  
>
>>In the example, bvec_alloc_bs does not initialize &idx when nr is not
>>between 1 and BIO_MAX_PAGES, so gcc is telling the truth here.
>>    
>>
>
>Wrong. idx is always initialized if being used.
>
>  
>
Is the compiler really that smart as it searches back into the parent-function and try all the combinations? Otherwise, Arnd is correct.
And on an philosophical plane, can/should we put that responsibility onto the compiler? Is it not "easier" to make the functions take care
of its own duties (like the *nix-way) and make the bvec_alloc_bs initialize idx (even if it has to be an error-value)?

I'm thinking something like this. Seems alright?

/Richard

---

diff -Nurp a/fs/bio.c b/fs/bio.c
--- a/fs/bio.c	2005-10-29 06:30:49.000000000 +0200
+++ b/fs/bio.c	2005-10-29 06:33:00.000000000 +0200
@@ -90,6 +90,7 @@ static inline struct bio_vec *bvec_alloc
 		case  65 ... 128: *idx = 4; break;
 		case 129 ... BIO_MAX_PAGES: *idx = 5; break;
 		default:
+			*idx = -1;
 			return NULL;
 	}
 	/* 


