Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310394AbSCAIQ3>; Fri, 1 Mar 2002 03:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310404AbSCAIOY>; Fri, 1 Mar 2002 03:14:24 -0500
Received: from pcp01405920pcs.norstn01.pa.comcast.net ([68.80.16.119]:42369
	"EHLO ghoti.dhis.org") by vger.kernel.org with ESMTP
	id <S310403AbSCAIMz>; Fri, 1 Mar 2002 03:12:55 -0500
Date: Fri, 1 Mar 2002 03:03:27 -0500
From: Tim Peeler <timpeeler@comcast.net>
To: linux-kernel@vger.kernel.org
Subject: BUG _llseek kernel 2.4.17
Message-ID: <20020301080327.GA18948@comcast.net>
Mail-Followup-To: Tim Peeler <timpeeler@comcast.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a bug in _llseek (at least that's where I believe it to be)
in kernel 2.4.17.   I'm using ext3 on an ia32 system.  While pondering
max file sizes allowed on an ext3 system, I used 'dd' to create a
fairly large file (8 gigs).  I decided to append to it, so I ran another
dd to add another 200 megs to it. In telling dd where to seek to before
appending to the file, i inadvertantly added an extra 0 telling it to
seek to about 80 _Gigs_, not 8:

 $ dd if=/dev/zero of=really_big_file bs=1M count=200 seek=80000

I didn't notice what had happended until I checked the size of the file,
and saw that it was 80 Gigs.   Since my disk is only 9 Gigs, this threw
me off.  I tried dd several more times including:

 $ dd if=/dev/zero of=really_big_file bs=1M count=1 seek=999999

I now have a 977 Gig file on a 9 Gig disk.  using 'wc -c' to verify the
size gave me: 1048576000000 bytes.

I ran an strace on the 'dd' command to create the file.  _llseek seeks
the the proper position and returns 0 (as per the man page, success).
I ran an strace on the 'wc' command and see that it uses fstat64.  one
of it's parameters is st_size.  st_size is 1048576000000.  I assume that
fstat64 does the same as fstat, and fills in st_size (among other
things) in the stat struct pointer.  After the fstat64 we get 2 __llseeks:
 _llseek(3, 0, [0], SEEK_CUR), _llseek(3, 0, [1048576000000], SEEK_END)
both returning 0.

Now, it appears to me that _llseek definitly has a bug in it somewhere.
I'm unfamiliar with the kernel, so I can't find where.  The closest I
can find is generic_file_llseek, where it sets file->f_pos to the
offset if it is less than or equal to file->f_dentry->d_inode->i_sb->s_maxbytes 
or greater than 0.  I traced it back as far as ext3_max_size which is
the file max size, but I didn't find anything that took into account the
actual physical disk limitations (again, limited with experience with
the kernel prohibits me from being sure of this).

After this careful consideration of the problem in question and
the apparent area of failure, it seems that fstat is doing its job
right, just that _llseek setting the position is the culprit.

Tim

-- 
@a=(Lbzjoftt,Inqbujfodf,Hvcsjt); $b="Lbssz Wbmm"
;$b =~ y/b-z/a-z/ ; $c =" Tif ". @a ." hsfbu wj"
."suvft pg b qsphsbnnfs". ":\n";$c =~y/b-y/a-z/;
print"\n\n$c ";for($i=0;$i<@a; $i++) { $a[$i] =~
y/b-y/a-z/;if($a[$i]eq$a[-1]){print"and $a[$i]."
;}else{ print"$a[$i], ";}}print"\n\t\t--$b\n\n";


