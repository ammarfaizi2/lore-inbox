Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316822AbSFIGDS>; Sun, 9 Jun 2002 02:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317332AbSFIGDR>; Sun, 9 Jun 2002 02:03:17 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:31238 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S316822AbSFIGDQ>;
	Sun, 9 Jun 2002 02:03:16 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200206090603.g5963FA458690@saturn.cs.uml.edu>
Subject: Re: [patch] fat/msdos/vfat crud removal
To: hirofumi@mail.parknet.co.jp (OGAWA Hirofumi)
Date: Sun, 9 Jun 2002 02:03:15 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org, chaffee@cs.berkeley.edu
In-Reply-To: <87d6v1doq3.fsf@devron.myhome.or.jp> from "OGAWA Hirofumi" at Jun 09, 2002 02:07:32 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi writes:
> "Albert D. Cahalan" <acahalan@cs.uml.edu> writes:
>> OGAWA Hirofumi writes:
>>> "Albert D. Cahalan" <acahalan@cs.uml.edu> writes:

>>>> - * Conversion from and to little-endian byte order. (no-op on i386/i486)
>>>> - *
>>>> - * Naming: Ca_b_c, where a: F = from, T = to, b: LE = little-endian,
>>>> - * BE = big-endian, c: W = word (16 bits), L = longword (32 bits)
>>>> - */
>>>> -
>>>> -#define CF_LE_W(v) le16_to_cpu(v)
>>>> -#define CF_LE_L(v) le32_to_cpu(v)
>>>> -#define CT_LE_W(v) cpu_to_le16(v)
>>>> -#define CT_LE_L(v) cpu_to_le32(v)
>>>
>>> Personally I think this patch makes code readable. But please don't
>>> remove Cx_LE_x macros. Cx_LE_x is used from dosfsck.
>>
>> Then the macros should be put in dosfsck, which is not
>> part of the kernel.
>
> Why do we throw away backward compatible?

1. app source code isn't supposed to use raw kernel headers
2. existing executables are not affected
3. the 2.5.xx series has already broken much more
4. it's crud for the kernel; it's crud for user code
5. the kernel shouldn't contain misc. user app code

>>> -	logical_sector_size =
>>> -		le16_to_cpu(get_unaligned((unsigned short *) &b->sector_size));
>>> +	logical_sector_size = le16_to_cpu(get_unaligned((u16*)&b->sector_size));
>>
>> I notice lots of casts in the code. It would be better to
>> use the correct types to begin with.
>
> No, this field is aliment problem.

Use the packed attribute on the struct, along with
the right types. I don't think you need get_unaligned
with a packed struct, because gcc will know that it
needs to emit code for unaligned data.

At the very least you can get rid of the cast.

Before:
logical_sector_size = le16_to_cpu(get_unaligned((u16*)&b->sector_size));

After:
logical_sector_size = le16_to_cpu(b->sector_size);

The new struct:

/* Note the end: __attribute__ ((packed)) */
struct fat_boot_sector {
        char    ignored[3];     /* Boot strap short or near jump */
        __u64   system_id;      /* Name - can be used to special case
                                   partition manager volumes */
        __u16   sector_size;    /* bytes per logical sector */
        __u8    cluster_size;   /* sectors/cluster */
        __u16   reserved;       /* reserved sectors */
        __u8    fats;           /* number of FATs */
        __u16   dir_entries;    /* root directory entries */
        __u16   sectors;        /* number of sectors */
        __u8    media;          /* media code */
        __u16   fat_length;     /* sectors/FAT */
        __u16   secs_track;     /* sectors per track */
        __u16   heads;          /* number of heads */
        __u32   hidden;         /* hidden sectors (unused) */
        __u32   total_sect;     /* number of sectors (if sectors == 0) */

        /* The following fields are only used by FAT32 */
        __u32   fat32_length;   /* sectors/FAT */
        __u16   flags;          /* bit 8: fat mirroring, low 4: active fat */
        __u16   version;        /* major, minor filesystem version */
        __u32   root_cluster;   /* first cluster in root directory */
        __u16   info_sector;    /* filesystem info sector */
        __u16   backup_boot;    /* backup boot sector */
        __u16   reserved2[6];   /* Unused */
} __attribute__ ((packed)) ;
