Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130204AbQLGQdY>; Thu, 7 Dec 2000 11:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130235AbQLGQdO>; Thu, 7 Dec 2000 11:33:14 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:16143 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S130204AbQLGQdI>; Thu, 7 Dec 2000 11:33:08 -0500
Date: Thu, 7 Dec 2000 18:15:13 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Tigran Aivazian <tigran@veritas.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Broken NR_RESERVED_FILES
In-Reply-To: <Pine.LNX.4.21.0012071537480.970-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.30.0012071758470.5455-100000@fs129-190.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 7 Dec 2000, Tigran Aivazian wrote:
> On Thu, 7 Dec 2000, Szabolcs Szakacsits wrote:
> > again. The failed logic is also clear from the kernel code [user
> > happily allocates when freelist < NR_RESERVED_FILES].
>
> is it clear to you? it is not clear to me, or rather the opposite seems
> clear. This is what the code looks like (in 2.4):
>
> struct file * get_empty_filp(void)
> {
>         static int old_max = 0;
>         struct file * f;
>
>         file_list_lock();
>         if (files_stat.nr_free_files > NR_RESERVED_FILES) {
>         used_one:
>                 f = list_entry(free_list.next, struct file, f_list);
>                 list_del(&f->f_list);
>                 files_stat.nr_free_files--;
>
> so, a normal user is only allowed to allocate from the freelist when the
> number of elements on the freelist is > NR_RESERVED_FILES. I do not see
> how you are able to take elements from the freelist when the number is <
> NR_RESERVED_FILES unless you are a super-user, i.e. current->euid == 0.

Read the whole get_empty_filp function, especially this part, note the
goto new_one below and the part you didn't include above [from
the new_one label],

        if (files_stat.nr_files < files_stat.max_files) {
                file_list_unlock();
                f = kmem_cache_alloc(filp_cachep, SLAB_KERNEL);
                file_list_lock();
                if (f) {
                        files_stat.nr_files++;
                        goto new_one;
                }

> Btw, while you are there (in 2.2 kernel) you may want to fix the

Sorry, no time.

	Szaka

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
