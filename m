Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270517AbRHHQNw>; Wed, 8 Aug 2001 12:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270518AbRHHQNk>; Wed, 8 Aug 2001 12:13:40 -0400
Received: from paloma16.e0k.nbg-hannover.de ([62.159.219.16]:58814 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S270517AbRHHQNZ>; Wed, 8 Aug 2001 12:13:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Daniel Phillips <phillips@bonn-fries.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.7-ac4 disk thrashing
Date: Wed, 8 Aug 2001 18:03:36 +0200
X-Mailer: KMail [version 1.2.3]
Cc: linux-kernel@vger.kernel.org (Linux Kernel List),
        reiserfs-list@namesys.com (ReiserFS List),
        mason@suse.com (Chris Mason), NikitaDanilov@Yahoo.COM (Nikita Danilov),
        tmv5@home.com (Tom Vier)
In-Reply-To: <E15UR2B-00051d-00@the-village.bc.nu> <01080817411402.00351@starship>
In-Reply-To: <01080817411402.00351@starship>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010808161334Z270517-28344+3065@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 8. August 2001 17:41 schrieb Daniel Phillips:
> On Wednesday 08 August 2001 12:57, Alan Cox wrote:
> > > Could it be that the ReiserFS cleanups in ac4 do harm?
> > > http://marc.theaimsgroup.com/?l=3Dreiserfs&m=3D99683332027428&w=3D2
> >
> > I suspect the use once patch is the more relevant one.
>
> Two things to check:
>
>   - Linus found a bug in balance_dirty_state yesterday.  Is the
>     fix applied?

No, I'll try.

>   - The original use-once patch tends to leave a referenced pages
>     on the inactive_dirty queue longer, not in itself a problem,
>     but can expose other problems.  The previously posted patch
>     below fixes that, is it applied?
>
> To apply (with use-once already applied):

Yes, it was with -ac9.

But it wasn't much different from ac6/7/8 without it. All nearly "equally 
bad". The disk steps like mad compared against 2.4.7-ac1 and ac-3. I can 
"hear" it and the whole system "feels" slow.
2.4.7-ac1 + transaction-tracking-2 (Chris) + use-once-pages 
(Daniel) + 2.4.7-unlink-truncate-rename-rmdir.dif (Nikita) is the best Linux 
I've ever run.

I did several (~10 times) dbench-1.1 (should I retry with dbench-1.2?) and 
all gave nearly same results.

ac-1, ac3 + fixes			GREAT
ac5, ac6, ac7, ac8, ac9 + fixes	BAD

Thanks,
	Dieter

>   cd /usr/src/your.2.4.7.source.tree
>   patch -p0 <this.patch
>
> --- ../2.4.7.clean/mm/filemap.c	Sat Aug  4 14:27:16 2001
> +++ ./mm/filemap.c	Sat Aug  4 23:41:00 2001
> @@ -979,9 +979,13 @@
>
>  static inline void check_used_once (struct page *page)
>  {
> -	if (!page->age) {
> -		page->age = PAGE_AGE_START;
> -		ClearPageReferenced(page);
> +	if (!PageActive(page)) {
> +		if (page->age)
> +			activate_page(page);
> +		else {
> +			page->age = PAGE_AGE_START;
> +			ClearPageReferenced(page);
> +		}
>  	}
>  }
