Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129381AbRDBNfH>; Mon, 2 Apr 2001 09:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129359AbRDBNe7>; Mon, 2 Apr 2001 09:34:59 -0400
Received: from bagel.indexdata.dk ([212.242.69.115]:37639 "EHLO
	bagel.indexdata.dk") by vger.kernel.org with ESMTP
	id <S129381AbRDBNer>; Mon, 2 Apr 2001 09:34:47 -0400
Date: Mon, 2 Apr 2001 15:33:54 +0200
From: Adam Dickmeiss <adam@indexdata.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: pthreads & fork & execve
Message-ID: <20010402153354.A15933@indexdata.dk>
In-Reply-To: <01033016225700.00409@dennis> <Pine.LNX.4.21.0104021338320.8447-100000@bellatrix.tat.physik.uni-tuebingen.de> <20010402095425.A15554@tux.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010402095425.A15554@tux.distro.conectiva>; from niemeyer@conectiva.com on Mon, Apr 02, 2001 at 09:54:25AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, Apr 02, 2001 at 09:54:25AM -0300, Gustavo Niemeyer wrote:
> Hi Richard! Hi Dennis!
> 
> > I tracked this down to a corrupt jumptable somewhere in the pthreads
> > part of the libc (didnt have the source handy at that time, though). So
> > I think this is a libc bug (version does not matter) - I even did a
> > followup to a similar bug in the libc gnats database (I think I should
> > have opened a new one, though...). But I failed to construct a "simple"
> > testcase showing the bug (We use rather large amount of threads and
> > in one or two doing popen() calls - or handcrafted fork() && execv(),
> > the SIGSEGV is during fork()).
> 
> We're going trough two similar problems here. One is KDE, and the other
> is Linuxconf. Linuxconf is core dumping on a module when it is linked
> with pthread and dlopen()'ed with RTLD_GLOBAL. We must reduce one of
> them to a testcase.
> 
> Btw, both are mainly C++ programs. Is your software written in C++?
> 
> > I stopped trying to find out what is going on as this feature is not
> > essential (but maybe useful in the future). So I suggest you build a
> > libc from source with debugging on and trace it down to the actual
> > libc problem - or better try to isolate a simple testcase.

People making Apache 1.3.X modules have a problem too. They have to
rebuilt Apache and add -lpthread if any modules uses threads.

The following small program illustrates this. The program, main-wot,
crashes  - the other, main-wt, doesn't.

[snip] sub.c:
int sub(void) { return 1; }

[snip] main.c:

#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>

int main(int argc, char **argv)
{
        void *h = dlopen ("./sub.so", RTLD_NOW|RTLD_GLOBAL);
        if (!h)
        {
                printf ("dlopen failed\n");
                exit (1);
        }
        gethostbyname("slashdot.org");
        dlclose (h);
        exit (0);
}

[snip] Makefile
all: sub.so main-wt main-wot

sub.so: sub.c
        gcc -D_REENTRANT -shared sub.c -o sub.so -lpthread
main-wt: main.c
        gcc main.c -o main-wt -ldl -lpthread
main-wot: main.c
        gcc main.c -o main-wot -ldl
[end]

Cheers,
  Adam

> We'll probably do this here...
> 
> > I like to hear from the results :)
> 
> Please, let me know as well! :-)
> 
> Thanks!!
> 
> -- 
> Gustavo Niemeyer
> 
> [ 2AAC 7928 0FBF 0299 5EB5  60E2 2253 B29A 6664 3A0C ]
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Adam Dickmeiss  mailto:adam@indexdata.dk  http://www.indexdata.dk
Index Data      T: +45 33410100           Mob.: 212 212 66
