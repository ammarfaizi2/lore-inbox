Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267176AbSKSTXZ>; Tue, 19 Nov 2002 14:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267192AbSKSTXY>; Tue, 19 Nov 2002 14:23:24 -0500
Received: from air-2.osdl.org ([65.172.181.6]:10927 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267176AbSKSTXE>;
	Tue, 19 Nov 2002 14:23:04 -0500
Subject: Re: [ANNOUNCE][CFT] kexec for v2.5.48 && kexec-tools-1.7 -- Success
	Story!
From: Andy Pfiffer <andyp@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <m1adk51n0e.fsf@frodo.biederman.org>
References: <Pine.LNX.4.44.0211091901240.2336-100000@home.transmeta.com>
	<m1vg349dn5.fsf@frodo.biederman.org> <1037055149.13304.47.camel@andyp>
	<m1isz39rrw.fsf@frodo.biederman.org> <1037148514.13280.97.camel@andyp>
	<m1k7jb3flo.fsf_-_@frodo.biederman.org>
	<m1el9j2zwb.fsf@frodo.biederman.org>
	<m11y5j2r9t.fsf_-_@frodo.biederman.org> <1037668241.10400.48.camel@andyp>
	<m1isyt26wr.fsf@frodo.biederman.org> <1037726468.10400.81.camel@andyp> 
	<m1adk51n0e.fsf@frodo.biederman.org>
Content-Type: multipart/mixed; boundary="=-LqGcdCykaRKqWBrfgb2w"
X-Mailer: Ximian Evolution 1.0.5 
Date: 19 Nov 2002 11:29:50 -0800
Message-Id: <1037734192.10277.93.camel@andyp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LqGcdCykaRKqWBrfgb2w
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2002-11-19 at 09:34, Eric W. Biederman wrote:
> Andy Pfiffer <andyp@osdl.org> writes:
> 
> > On Tue, 2002-11-19 at 02:25, Eric W. Biederman wrote:
> > > > Complete kernel boot-up log attached below.  I'm going to try to find my
> > > > other 576MB of RAM with the right command-line magic... ;^)
> > > 
> > > Or you can write a routine to gather that information dynamically and send
> > > me a patch for /sbin/kexec.  Though it may take another proc file to do
> > > that one properly.
> > > 
> > > Eric

Hmmm...I seem to be having some trouble setting "mem=" (system hangs). 
Maybe multiple "mem=NNNK@0xXXXXXXXX" options won't work.

While I try to figure out what's going on, here's a program ("kargs")
that composes a kernel command line from the contents of
"/proc/cmndline" and "/proc/iomem".  It doesn't do as much error
checking as it should...

Usage (sh quoting): kexec --force "--command-line=`kargs`" bzImage

Andy



--=-LqGcdCykaRKqWBrfgb2w
Content-Disposition: attachment; filename=kargs.c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-c; name=kargs.c; charset=ISO-8859-1

/*
 *	andyp@osdl.org
 *	Tue Nov 19 09:26:22 PST 2002
 *
 *	Compose a kernel command line on stdout from the contents
 *	of /proc/iomem and /proc/cmndline.
 */

#include <stdio.h>
#include <stdlib.h>
#include <regex.h>


struct memregion {
	unsigned long		first;
	unsigned long		last;
	struct memregion	*next;
};


int memopt(char *iomem, char *out, int outlen)
{
	FILE	*f;
	struct memregion *list, *tmp;
	char	*pattern;
	regex_t	preg;
	int	cc, kb;
	char	line[256];

	if ((f =3D fopen(iomem, "r")) =3D=3D NULL)
		return -1;

	pattern =3D "^[0-9a-fA-F].*-[0-9a-fA-F].* : System RAM";
	if (regcomp(&preg, pattern, 0)) {
		(void) fclose(f);
		return -1;
	}

	list =3D (struct memregion *) 0;
	while (fgets(line, sizeof(line), f) !=3D NULL) {
		if (regexec(&preg, line, 0, 0, 0) =3D=3D REG_NOMATCH)
			continue;
		tmp =3D (struct memregion *) malloc(sizeof(struct memregion));
		if (tmp =3D=3D (struct memregion *) 0)
			goto out;
		cc =3D sscanf(line, "%x-%x", &tmp->first, &tmp->last);
		if (cc !=3D 2) {
			free(tmp);
			goto out;
		}
		tmp->next =3D list;
		list =3D tmp;
	}

	out[0] =3D 0;
	tmp =3D list;
	while (tmp) {
		strcat(out, "mem=3D");
		kb =3D (tmp->last - tmp->first + 1) >> 10;
		sprintf(line, "%dK@0x%08x", kb, tmp->first);
		strcat(out, line);
		if (tmp->next)
			strcat(out, " ");
		tmp =3D tmp->next;
	}

out:
	while (list) {
		tmp =3D list->next;
		free(list);
		list =3D tmp;
	}
	regfree(&preg);
	(void) fclose(f);

	return 0;
}


static int lastcmd(char *cmndline, char *out, int outlen)
{
	FILE	*f;
	char	line[256];

	if ((f =3D fopen(cmndline, "r")) =3D=3D NULL)
		return -1;
	memset(out, 0, outlen);
	if (fgets(line, sizeof(line), f) !=3D NULL)
		strncpy(out, line, strlen(line) - 1);
	fclose(f);
	return 0;
}


int main(int argc, char **argv)
{
	int	cc;
	char	*name;
	char	memline[256];
	char	curline[256];

	name =3D "/proc/iomem";
	cc =3D memopt(name, memline, sizeof(memline));
	if (cc < 0) {
		perror(name);
		exit(1);
	}

	name =3D "/proc/cmdline";
	cc =3D lastcmd(name, curline, sizeof(curline));
	if (cc < 0) {
		perror(name);
		exit(1);
	}

	printf("%s %s\n", curline, memline);
	exit(0);
}

--=-LqGcdCykaRKqWBrfgb2w--

