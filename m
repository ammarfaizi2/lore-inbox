Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310140AbSCALEC>; Fri, 1 Mar 2002 06:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310431AbSCAK77>; Fri, 1 Mar 2002 05:59:59 -0500
Received: from mail.starbak.net ([63.144.91.12]:31245 "EHLO mail.starbak.net")
	by vger.kernel.org with ESMTP id <S310436AbSCAK4x>;
	Fri, 1 Mar 2002 05:56:53 -0500
Message-ID: <010a01c1c10f$45a695e0$5a5b903f@h90>
From: "Joseph Malicki" <jmalicki@starbak.net>
To: "Tim Peeler" <timpeeler@comcast.net>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20020301080327.GA18948@comcast.net>
Subject: Re: BUG _llseek kernel 2.4.17
Date: Fri, 1 Mar 2002 05:53:07 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse files.  If you never wrote to it, it never got a block on disk... the
kernel will return zeroes for said portions of file when you read it.

-joe

----- Original Message -----
From: "Tim Peeler" <timpeeler@comcast.net>
To: <linux-kernel@vger.kernel.org>
Sent: Friday, March 01, 2002 3:03 AM
Subject: BUG _llseek kernel 2.4.17


> There is a bug in _llseek (at least that's where I believe it to be)
> in kernel 2.4.17.   I'm using ext3 on an ia32 system.  While pondering
> max file sizes allowed on an ext3 system, I used 'dd' to create a
> fairly large file (8 gigs).  I decided to append to it, so I ran another
> dd to add another 200 megs to it. In telling dd where to seek to before
> appending to the file, i inadvertantly added an extra 0 telling it to
> seek to about 80 _Gigs_, not 8:
>
>  $ dd if=/dev/zero of=really_big_file bs=1M count=200 seek=80000
>
> I didn't notice what had happended until I checked the size of the file,
> and saw that it was 80 Gigs.   Since my disk is only 9 Gigs, this threw
> me off.  I tried dd several more times including:
>
>  $ dd if=/dev/zero of=really_big_file bs=1M count=1 seek=999999
>
> I now have a 977 Gig file on a 9 Gig disk.  using 'wc -c' to verify the
> size gave me: 1048576000000 bytes.
>
> I ran an strace on the 'dd' command to create the file.  _llseek seeks
> the the proper position and returns 0 (as per the man page, success).
> I ran an strace on the 'wc' command and see that it uses fstat64.  one
> of it's parameters is st_size.  st_size is 1048576000000.  I assume that
> fstat64 does the same as fstat, and fills in st_size (among other
> things) in the stat struct pointer.  After the fstat64 we get 2 __llseeks:
>  _llseek(3, 0, [0], SEEK_CUR), _llseek(3, 0, [1048576000000], SEEK_END)
> both returning 0.
>
> Now, it appears to me that _llseek definitly has a bug in it somewhere.
> I'm unfamiliar with the kernel, so I can't find where.  The closest I
> can find is generic_file_llseek, where it sets file->f_pos to the
> offset if it is less than or equal to
file->f_dentry->d_inode->i_sb->s_maxbytes
> or greater than 0.  I traced it back as far as ext3_max_size which is
> the file max size, but I didn't find anything that took into account the
> actual physical disk limitations (again, limited with experience with
> the kernel prohibits me from being sure of this).
>
> After this careful consideration of the problem in question and
> the apparent area of failure, it seems that fstat is doing its job
> right, just that _llseek setting the position is the culprit.
>
> Tim
>
> --
> @a=(Lbzjoftt,Inqbujfodf,Hvcsjt); $b="Lbssz Wbmm"
> ;$b =~ y/b-z/a-z/ ; $c =" Tif ". @a ." hsfbu wj"
> ."suvft pg b qsphsbnnfs". ":\n";$c =~y/b-y/a-z/;
> print"\n\n$c ";for($i=0;$i<@a; $i++) { $a[$i] =~
> y/b-y/a-z/;if($a[$i]eq$a[-1]){print"and $a[$i]."
> ;}else{ print"$a[$i], ";}}print"\n\t\t--$b\n\n";
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

