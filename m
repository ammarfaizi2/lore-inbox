Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130076AbQK1XyL>; Tue, 28 Nov 2000 18:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130138AbQK1XyB>; Tue, 28 Nov 2000 18:54:01 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:22711 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S130076AbQK1Xxr>;
        Tue, 28 Nov 2000 18:53:47 -0500
Date: Tue, 28 Nov 2000 18:23:45 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Peter Cordes <peter@llama.nslug.ns.ca>
cc: Andries Brouwer <aeb@veritas.com>, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: access() says EROFS even for device files if /dev is mounted RO
In-Reply-To: <20001128185609.A2960@llama.nslug.ns.ca>
Message-ID: <Pine.GSO.4.21.0011281805000.11331-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 28 Nov 2000, Peter Cordes wrote:

>  I'm of the opinion that Linux should work in the way that is most useful,
> as long as that doesn't stop us from running stuff written for other unices.
> Unix is mostly good, but parts of it suck.  There's no reason to keep the
> parts that suck, except when needed for compatibility.  Changing the
> behaviour of access here would not introduce security holes in anything, so
> I think it should be changed to the more sensible way.
> 
> (That last paragraph is purely my opinion.  I'm pretty sure not everyone
> shares it!)

The funny thing being, access() _was_ consistent with open(). Relevant code
(I doubt that AT&T will care):

/*
 * open system call
 */
open()
{
        register struct inode *ip;
        register struct a {
                char    *fname;
                int     rwmode;
        } *uap;

        uap = (struct a *)u.u_ap;
        ip = namei(uchar, 0);
        if(ip == NULL)
                return;
        open1(ip, ++uap->rwmode, 0);
}

open1(ip, mode, trf)
register struct inode *ip;
register mode;
{
        register struct file *fp;
        int i;

        if(trf != 2) {
                if(mode&FREAD)
                        access(ip, IREAD);
                if(mode&FWRITE) {
                        access(ip, IWRITE);
                        if((ip->i_mode&IFMT) == IFDIR)
                                u.u_error = EISDIR;
                }
        }
        if(u.u_error)
                goto out;
....
out:
        iput(ip);
}

access(ip, mode)
register struct inode *ip;
{
        register m;

        m = mode;
        if(m == IWRITE) {
                if(getfs(ip->i_dev)->s_ronly != 0) {
                        u.u_error = EROFS;
                        return(1);
                }
....
}

See what happens? open() calls open1(ip, mode, 0), we check that rtf is
not 2 and call access(ip, mode). Which sets u.u_error to EROFS and we
return from open1() (and open()). Failing. So behaviour of access()
was pretty and consistent with open().

When opening devices for write became allowed even for r/o filesystems
access() also had to be changed. And changed it was, back in mid-80s.
It's way older than Linux. Changing one of them and leaving another
as-is means introducing a bug. If standard admits one but not another -
standard is buggy. Again, when 4.*BSD (and 2.*BSD) allowed opening devices
for write even for nodes on r/o filesystems they did change access().

If standard in question doesn't allow such use of open() - too fscking bad.
For standard. Because I'll take the ability to boot from r/o media and
install the system (kinda requires ability to run mkfs) over POSIX/SuS
compliance any day.

<looking into SuS> Oh, lovely...
   [EROFS]
          The named file resides on a read-only file system and either
          O_WRONLY, O_RDWR, O_CREAT (if file does not exist) or O_TRUNC
          is set in the oflag argument.

Wonderful. Andries, care to try pushing _that_ kind of standard-compliance?
It _is_ consistent, all right. And utterly wrong.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
