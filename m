Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129111AbRBEUJx>; Mon, 5 Feb 2001 15:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129929AbRBEUJn>; Mon, 5 Feb 2001 15:09:43 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:64239 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129111AbRBEUJa>; Mon, 5 Feb 2001 15:09:30 -0500
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Mathias.Froehlich@gmx.net
Subject: Re: [patch] make tmpfs_statfs more user friendly
In-Reply-To: <200102051833.f15IXhv21604@webber.adilger.net>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <200102051833.f15IXhv21604@webber.adilger.net>
Message-ID: <m3ae80dhl9.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 05 Feb 2001 21:14:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Mon, 5 Feb 2001, Andreas Dilger wrote:
>> diff -uNr 2.4.1-tmpfs/mm/shmem.c 2.4.1-tmpfs-fstat/mm/shmem.c
>> --- 2.4.1-tmpfs/mm/shmem.c	Sun Feb  4 16:08:57 2001
>> +++ 2.4.1-tmpfs-fstat/mm/shmem.c	Sun Feb  4 16:09:50 2001
>> @@ -696,13 +696,20 @@
>>  	buf->f_type = TMPFS_MAGIC;
>>  	buf->f_bsize = PAGE_CACHE_SIZE;
>>  	spin_lock (&sb->u.shmem_sb.stat_lock);
>> -	if (sb->u.shmem_sb.max_blocks != ULONG_MAX || 
>> -	    sb->u.shmem_sb.max_inodes != ULONG_MAX) {
>> +	if (sb->u.shmem_sb.max_blocks == ULONG_MAX) {
>> +		/*
>> +		 * This is only a guestimate and not honoured.
>> +		 * We need it to make some programs happy which like to
>> +		 * test the free space of a file system.
>> +		 */
>> +		buf->f_bavail = buf->f_bfree = nr_free_pages() + nr_swap_pages + atomic_read(&buffermem_pages);
> 
> Should f_bavail be reduced by freepages.min or freepages.low?

Is it still used? If yes, good idea.

>> + buf->f_blocks = buf->f_bfree + ULONG_MAX - sb->u.shmem_sb.free_blocks;
> 
> It's not really clear what you are trying to calculate here... 

(ULONG_MAX - sb->u.shmem_sb.free_blocks) is the number of occupied
blocks by this instance. So the size of the instance should be clearly
buf->f_bfree + ULONG_MAX - sb->u.shmem_sb.free_blocks

> Since f_blocks is a long, adding ULONG_MAX == subtracting 1.  Maybe
> it should just hold the total amount of VM in the system,
> (i.e. totalram_pages)?

Nope, see above

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
