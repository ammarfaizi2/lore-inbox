Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136814AbRECOEq>; Thu, 3 May 2001 10:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136817AbRECOEh>; Thu, 3 May 2001 10:04:37 -0400
Received: from ip165-37.fli-ykh.psinet.ne.jp ([210.129.165.37]:19910 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id <S136814AbRECOE1>;
	Thu, 3 May 2001 10:04:27 -0400
Message-ID: <3AF16566.D682BF38@yk.rim.or.jp>
Date: Thu, 03 May 2001 23:04:22 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2GB swap partition limit
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J. A. Magallon wrote:
>I'm not so sure it's only a 'rule of thumb'. Do not know the state of
>paging in just released 2.4.4, but in previuos kernel, a page that was
>paged-out, reserves its place in swap even if it is paged-in again, so
>once you have paged-out all your ram at least once, you can't get any
>more memory, even if swap is 'empty'.

I am not sure if I see the behavior of the kernel mentioned above, but
it seems that once the swap partition is used,
it may not be released forever : kernel 2.4.x.

Background:
I experienced a very strange X server crash (when a certain page
is access via netscape, and a string is searched successively,
on the second or the third search, the X server crash.)
I downloaded the Xfree 86 source file to re-create the problem and
see where the segmentation error of X server occurs by having a server
with debug symbols in it, and finally
traced it to an incorrect pointer value used in the backing store bitblt
routine.
However, I can't see the pointer value is an incorrect one at all.
(Maybe I am not familar enough with mmap and unmap calls invoked
by malloc() and free().)
Also, I was a little surprised to see a bug of this nature to remain
in X server at this stage.

Anyway, suspecting some sort of VM problem on the kernel side,
I wrote the attached program and run it to see
the behavior of the system when swap partition was first used.
(The situation where X server crashes is when the system is
just about to use Swap in my current config: 256 MB memory
and 80MB swap).

After running the few invocation of the attached program with
varying arguments, I noticed that once the swap is used (I view it
usinx xosview from X or cat /proc/meminfo ).
the used swap does not seem to get released!?

I thought it was suspicious, but didn't speak up since if this were
a bug, this would  indeed be a showstopper for many commercial
application.
Someone must have realized this and fixed it already, so I thought.

>From the current discussion, I notice that this may be indeed
an unwanted behavior.
If this is a bug of 2.4.x VM, then I think some installations
would appreciate it very much.


--- memhog.c

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

/*
 * using realloc() will call mremap().
 * using malloc() and free calls mmap, and munmap().
 */
static usage()
{
  fprintf(stderr,"memhog [limit]\nlimit is in MB units Default is 64
(MB).\n");
  exit(EXIT_FAILURE);
}

int main(argc, argv)
     int argc;
     char *argv[];
{

  int i;
  char *p = NULL;

#define MB (1024 * 1024 )
  int limit = 64 * MB;

  if (argc == 2)
    {
      int t;
      t = atoi(argv[1]);
      if(t <= 0)
        {
          usage();
        }

      limit = t * MB;

    }
  else if (argc >= 3)
    {
      usage();
    }


  i = MB;

  while (i <= limit )
    {
      printf("i = %d\n", i);

#ifdef USE_REALLOC
      p = realloc(p, i);
#else
      p = malloc(i);
#endif

      if( p == NULL)
        {
          printf("malloc returned NULL\n");
          exit(EXIT_FAILURE);
        }

      memset(p, 0xA5, i);

      sleep (1);

#ifdef USE_REALLOC
      /* free(p); */
#else
      free(p);
#endif

      /*     i *= 2; */
      i += 1 * MB;
    }


  exit (EXIT_SUCCESS);

}




