Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbWCOI0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWCOI0z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 03:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbWCOI0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 03:26:55 -0500
Received: from wildsau.enemy.org ([193.170.194.34]:62089 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S1751376AbWCOI0z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 03:26:55 -0500
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200603150823.k2F8NdWL016554@wildsau.enemy.org>
Subject: Re: procfs uglyness caused by "cat"
In-Reply-To: <4416D4A3.9070705@shaw.ca>
To: Robert Hancock <hancockr@shaw.ca>
Date: Wed, 15 Mar 2006 09:23:39 +0100 (MET)
CC: linux-kernel <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > static int uptime_read_proc(char *page, char **start, off_t off,
> > >                                  int count, int *eof, void *data)
> > > {
> > >         struct timespec uptime;
> > >         struct timespec idle;
> > >         int len;
> > >         cputime_t idletime;
> > > 
> > > +	if (off)
> > > +		return 0;
> > 
> > Except that this is wrong - if you try to advance the offset a bit from 
> > the start of the file and read something, you'll get nothing. This is 
> > inconsistent with normal file behavior.
> 
> so what - "uptime_read_proc" ignores the offset parameter anyway.
> you get wrong results right now, too, even without the two lines
> I've added.
> 
> if you write "Except that this is wrong" you should have in mind that
> "this is wrong" currently, too.
> 
> just "try to advance the offset a bit from the start of the file and
> read something", like "dd if=/proc/uptime bs=1 count=1 seek=1".
> do you expect to get right results?

argh, my mistake, sorry. I see. I tried reading a character at a time
and with the two lines, /proc/uptime will return only a single character.

so even though currently the update-routine is called more than
needed, my patch is even more wrong.

but this means that e.g.:

    int main() {
    int fd;
    char ch;
            fd=open("/proc/uptime",0);
            for(;;) {
                    if (read(fd,&ch,1)!=1)
                            break;
                    write(1,&ch,1);
            }
    }

will call the buffer-formatting routines 16 times on the whole
buffer, just to return 1 single character, and each call will
return a different result. eeks...

by the way: why does "dd if=/proc/uptime bs=1 seek=1" hang?
e.g.:

    root@afp ~ # strace -f dd if=/proc/uptime bs=1 count=1 seek=1
    open("/proc/uptime", O_RDONLY|O_LARGEFILE) = 0
    ...
    _llseek(1, 1, 0xbfaa8464, SEEK_CUR)     = -1 ESPIPE (Illegal seek)
    read(1, <unfinished ...>

processing stops here.


regards,
h.rosmanith


regards,
h.rosmanith
