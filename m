Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLGQL6>; Thu, 7 Dec 2000 11:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129535AbQLGQLt>; Thu, 7 Dec 2000 11:11:49 -0500
Received: from 212-140-94-250.btopenworld.com ([212.140.94.250]:28166 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129267AbQLGQLf>;
	Thu, 7 Dec 2000 11:11:35 -0500
Date: Thu, 7 Dec 2000 15:43:02 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Szabolcs Szakacsits <szaka@f-secure.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Broken NR_RESERVED_FILES
In-Reply-To: <Pine.LNX.4.30.0012071642300.5455-100000@fs129-190.f-secure.com>
Message-ID: <Pine.LNX.4.21.0012071537480.970-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Szabolcs Szakacsits wrote:
> again. The failed logic is also clear from the kernel code [user
> happily allocates when freelist < NR_RESERVED_FILES].

is it clear to you? it is not clear to me, or rather the opposite seems
clear. This is what the code looks like (in 2.4):

struct file * get_empty_filp(void)
{
        static int old_max = 0;
        struct file * f;

        file_list_lock();
        if (files_stat.nr_free_files > NR_RESERVED_FILES) {
        used_one:
                f = list_entry(free_list.next, struct file, f_list);
                list_del(&f->f_list);
                files_stat.nr_free_files--;

so, a normal user is only allowed to allocate from the freelist when the
number of elements on the freelist is > NR_RESERVED_FILES. I do not see
how you are able to take elements from the freelist when the number is <
NR_RESERVED_FILES unless you are a super-user, i.e. current->euid == 0.

Btw, while you are there (in 2.2 kernel) you may want to fix the
/proc/sys/fs/file-nr -- it is broken because it assumes that nr_files,
nr_free_files, max_files are allocated by the compiler at consecutive
addresses. I have fixed this for 2.4 ages ago but couldn't be bothered
with 2.2.x...

Regards,
Tigran


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
