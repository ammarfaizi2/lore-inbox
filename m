Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbUJZXvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbUJZXvb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 19:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbUJZXvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 19:51:31 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:40129 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261548AbUJZXvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 19:51:08 -0400
Subject: Re: [PATCH 2.4] the perils of kunmap_atomic
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Douglas Gilbert <dougg@torque.net>, Jens Axboe <axboe@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <417EDE4C.20003@pobox.com>
References: <417EDE4C.20003@pobox.com>
Content-Type: text/plain
Message-Id: <1098834154.7298.29.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 27 Oct 2004 09:42:34 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.

On Wed, 2004-10-27 at 09:31, Jeff Garzik wrote:
> kunmap_atomic() violates the Principle of Least Surprise in a nasty way. 
>     kmap(), kunmap(), and kmap_atomic() all take struct page* to 
> reference the memory location.  kunmap_atomic() is the oddball of the 
> three, and takes a kernel address.
> 
> Ignoring the driver-related bugs that are present due to 
> kunmap_atomic()'s weirdness, there also appears to be a big in the 
> !CONFIG_HIGHMEM implementation in 2.4.x.
> 
> (Bart is poking through some of the 2.6.x-related kunmap_atomic slip-ups)
> 
> Anyway, what do people think about the attached patch to 2.4.x?  I'm 
> surprised it has gone unnoticed until now.
> 
> 	Jeff

On second thoughts, I think it's a bad idea to change the macro - in 2.6
at least. There are lots of uses of kunmap_atomic, and most of them do
the right thing. It's only inattentive people like me that need to fix
their code. :>

It would be good, though, to have kunmap_atomic warn on invalid
parameters (want a patch for that?)

Nigel

> 
> ______________________________________________________________________
> ===== include/linux/highmem.h 1.12 vs edited =====
> --- 1.12/include/linux/highmem.h	2003-06-30 20:18:42 -04:00
> +++ edited/include/linux/highmem.h	2004-10-26 19:26:14 -04:00
> @@ -70,7 +70,7 @@
>  #define kunmap(page) do { } while (0)
>  
>  #define kmap_atomic(page,idx)		kmap(page)
> -#define kunmap_atomic(page,idx)		kunmap(page)
> +#define kunmap_atomic(addr,idx)		kunmap(virt_to_page(addr))
>  
>  #define bh_kmap(bh)			((bh)->b_data)
>  #define bh_kunmap(bh)			do { } while (0)
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Everyone lives by faith. Some people just don't believe it.
Want proof? Try to prove that the theory of evolution is true.

