Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283758AbRLWF53>; Sun, 23 Dec 2001 00:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283757AbRLWF5U>; Sun, 23 Dec 2001 00:57:20 -0500
Received: from embolism.psychosis.com ([216.242.103.100]:40198 "EHLO
	embolism.psychosis.com") by vger.kernel.org with ESMTP
	id <S283860AbRLWF5D>; Sun, 23 Dec 2001 00:57:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: Ryan Cumming <bodnar42@phalynx.dhs.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: Booting a modular kernel through a multiple streams file
Date: Sun, 23 Dec 2001 00:52:32 -0500
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0112222109050.21702-100000@weyl.math.psu.edu> <E16Hysa-0002kc-00@schizo.psychosis.com> <E16I0S3-00019e-00@phalynx>
In-Reply-To: <E16I0S3-00019e-00@phalynx>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16I1Yc-0003eD-00@schizo.psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 December 2001 23:41, Ryan Cumming wrote:
> On December 22, 2001 19:00, Dave Cinege wrote:
> > Excellent! You've settled on using using an archiver format nobody uses,
>
> Many file formats that require 'embedded' archives use cpio. RPM is one
> such file format.

I know this, and have taken rpm's apart buy hand, and wrote 
a small util to take them apart using cpio. I consider it a good
example of Redhat's many screw up's. Deb's use a pair of .tgz's
and header. Much more sane.

> I think every single RPM distribution relying on cpio for

Hardly. It relies on rpm, which uses the cpio for the data archive.
It does not use the cpio command to make or unpackage archives. 

We're talking about a raw archive type, not something embedded in
a broader applicaiton. 

> the core of its package management system discounts your claim of 'nobody
> using it'. Just because you have not seen cpio directly used as an archive
> format doesn't mean it's unused.

How many times have you seen ANYTHING ditributed that way?

> As far as having tar already being implemented by at least two people, it
> really doesn't matter for a format as simple as cpio. Having a reference
> implementation for tar would be nice, as it is a hairy, complicated
> standard. 

You have no idea what you're talkig about, do you? Basic untar'ing is
quite simple. Now, GNU's tar as implented is pretty fucked up, but
that's not relevant to this.

> The cpio format can be fully described in less than a page.

Untar is implemented in less then 2. It doesn't get much smaller.

>From rd.dyn.c
---------------------
// This is called by flush_window to flush the gzip output
// buffer (containing part of a tar image).
UNTAR_WRITE
{
	int	i, scoop, err, file_written = 0;
	char	*to;
	kdev_t	fdev;
	struct	utimbuf ut;
	struct	untar_context *Untar;
#ifndef DEBUG_UNTAR
#ifndef CONFIG_ARCH_S390
	char rotator[4] = { '|' , '/' , '-' , '\\' };

	// pointer to our context structure is passed thru ioctl fop
	Untar = (struct untar_context*)fp->f_op->ioctl;

	printk("%c\b", rotator[Untar->rotate & 0x3]);
	Untar->rotate++;
#endif
#endif
	// Note: the gunzip routines call this only when
	//       a) the gunzip buffer is full -> count = WSIZE = 64 * TARBLOCKSIZE
	// or    b) to flush the last bytes out
	while(count) {	// What is our current state ?
		err = 0;	
		switch(Untar->state) {
			case READING_HEADER:
				// Get the tar header
				if(count < TARBLOCKSIZE) {
					count = 0;
					break;
				}
				to = (char*)&Untar->tarInfo;
				for(i = 0; i < TARBLOCKSIZE; i++) {
					*to++ = *buf++;
					--count;
				}
	
				// Tar usually pads the output byte to a multiple of it's block size usually
				// 10 KB, appending zeroes if necessary. Here we skip those zeroes:
				if(Untar->tarInfo.header.name[0] == '\0'  &&
				   Untar->tarInfo.header.mode[0] == '\0' &&
				   Untar->tarInfo.header.mode[0] == '\0') {
					if(count < TARBLOCKSIZE)
						count = 0;
					break;
				}
				// determine mode, size, uid, gid
				Untar->fmode = strtoul(Untar->tarInfo.header.mode,NULL,8);
				Untar->fsize = strtoul(Untar->tarInfo.header.size,NULL,8);
				Untar->uid = strtoul(Untar->tarInfo.header.uid,NULL,8);
				Untar->gid = strtoul(Untar->tarInfo.header.gid,NULL,8);
#ifdef DEBUG_UNTAR
				printk("\ntype: %c ",Untar->tarInfo.header.typeflag);   
				printk("name: %s ",Untar->tarInfo.header.name);
				printk("Untar->fsize: %ld ",Untar->fsize); 
				udelay(100000);
#endif
				// check the type
				switch(Untar->tarInfo.header.typeflag) {
					case AREGTYPE : 
					case REGTYPE  :
						Untar->out = sys_open(Untar->tarInfo.header.name,
					             O_CREAT|O_WRONLY|O_TRUNC, Untar->fmode);

						if(Untar->out == -1) {
							err = 1;
							break;
						}
						Untar->state = READING_DATA;
						break;
					case LNKTYPE  :
						err = sys_link(Untar->tarInfo.header.linkname,
						                  Untar->tarInfo.header.name);
						break;

					case SYMTYPE  :
						err = sys_symlink(Untar->tarInfo.header.linkname,
						                 Untar->tarInfo.header.name);
						break;

					case CHRTYPE  :	
					case BLKTYPE  :	
					case FIFOTYPE :	
						fdev = MKDEV(strtoul(Untar->tarInfo.header.devmajor,NULL,8),
						   strtoul(Untar->tarInfo.header.devminor,NULL,8));
						err = sys_mknod(Untar->tarInfo.header.name,Untar->fmode,fdev);
   	    				break;

					case DIRTYPE  :
						if((Untar->tarInfo.header.name[0] != '.' &&	// Skip if name is "" "./" "." ".." */
						    Untar->tarInfo.header.name[0] != '\0') &&
						   (Untar->tarInfo.header.name[1] != '/' &&
						    Untar->tarInfo.header.name[1] != '\0') &&
						   (Untar->tarInfo.header.name[1] != '\0')) {
							err = sys_mkdir(Untar->tarInfo.header.name,Untar->fmode);
						}
						break;
					default:
						printk(KERN_ERR "RAMDISK: corrupt tar archive\n");
						Untar->state = SKIPPING_REST;
						return(-1);
				}
				break;
			case READING_DATA:
				scoop = 0;
				while(count > 0 && Untar->fsize > 0) {
					scoop = Untar->fsize > TARBLOCKSIZE ? TARBLOCKSIZE : Untar->fsize;
					if(sys_write(Untar->out, buf, scoop) < scoop)
						err = 1;
					count -= scoop;
					buf   += scoop;
					Untar->fsize -= scoop;
				}
				if(Untar->fsize == 0) {	//skip to the next tar block
					sys_close(Untar->out);
					scoop = count % TARBLOCKSIZE;
					buf   += scoop;
					count -= scoop;
					Untar->state = READING_HEADER;
					file_written = 1;
				}
				break;

			case SKIPPING_REST:
				count = 0;
				break;
		}
		if(err)
			printk("!");
			//printk("\nError making %s", Untar->tarInfo.header.name);

		if(file_written) {
		
			err = sys_chown(Untar->tarInfo.header.name, Untar->uid, Untar->gid);
		
			if(Untar->tarInfo.header.typeflag != LNKTYPE &&
			   Untar->tarInfo.header.typeflag != SYMTYPE) {
				err += sys_chmod(Untar->tarInfo.header.name, Untar->fmode);
			}

			if(err)
				printk("\nError chown and/or chmod %s", Untar->tarInfo.header.name);
			ut.actime=sys_time(NULL);
			ut.modtime=strtoul(Untar->tarInfo.header.mtime,NULL,8);
			sys_utime(Untar->tarInfo.header.name,&ut);
			file_written = 0;
		}
	}
	return(0);
}

> > G-E-N-I-U-S!
>
> Grow up. Please.

Shut up Sit down!

-- 
The time is now 22:54 (Totalitarian)  -  http://www.ccops.org/
