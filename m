Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130153AbQLPBtf>; Fri, 15 Dec 2000 20:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130650AbQLPBtY>; Fri, 15 Dec 2000 20:49:24 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:63250 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S130153AbQLPBtM>;
	Fri, 15 Dec 2000 20:49:12 -0500
Date: Fri, 15 Dec 2000 17:18:56 -0800 (PST)
From: James Simmons <jsimmons@suse.com>
To: Kurt Garloff <garloff@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, miquels@cistron.nl,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: TIOCGDEV ioctl
In-Reply-To: <20001216015537.G21372@garloff.suse.de>
Message-ID: <Pine.LNX.4.21.0012151709591.1176-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi Linus, Alan,
> 
> some applications do need to know where the console (/dev/console)
> actually maps to. For processes with a controlling terminal, you may see 
> it in /proc/$$/stat. However, daemons are supposed to run detached (they
> don't want to get killed by ^C) and some processes like init or bootlogd 
> do still need to be able to find out.
> 
> The kernel provides this information -- sort of:
> It contains the TIOCTTYGSTRUCT syscall which returns a struct. Of course,
> it changes between different kernel archs and revisions, so using it is
> an ugly hack. Grab for TIOCTTYGSTRUCT_HACK in the bootlogd.c file of the
> sysvinit sources. Shudder!
> 
> Having a new ioctl, just returning the device no is a much cleaner solution,
> IMHO. So, I created the TIOCGDEV, which Miquel suggests in his sysvinit
> sources. It makes querying the actual console device as easy as 
> int tty; ioctl (0, TIOCGDEV, &tty);
> 
> Patches against 2.2.18 and 2.4.0-testX are attached.
> Please apply.

Based on fgconsole.c. I just threw it together in a few minutes.

/*
 * consolewhat.c - Prints which VC /dev/console is.
 */
#include <sys/ioctl.h>
#include <linux/vt.h>

int
main(){
    struct vt_stat vtstat;
    int fd;	

    fd = open("/dev/console", O_RDONLY);	

    if (fd < 0 && errno == EACCES)
	fd = open("/dev/console", O_WRONLY);
    if (fd < 0)
	return -1;

    if (ioctl(fd, VT_GETSTATE, &vtstat)) {
        perror("consolewhat: VT_GETSTATE");
	exit(1);
    }
    printf("%d\n", vtstat.v_active);
    return 0;
}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
