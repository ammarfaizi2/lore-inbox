Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267805AbRGRCow>; Tue, 17 Jul 2001 22:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267808AbRGRCom>; Tue, 17 Jul 2001 22:44:42 -0400
Received: from 209-6-16-34.c3-0.frm-ubr1.sbo-frm.ma.cable.rcn.net ([209.6.16.34]:35200
	"EHLO newyork.psind.com") by vger.kernel.org with ESMTP
	id <S267805AbRGRCoh>; Tue, 17 Jul 2001 22:44:37 -0400
Message-ID: <3B54F11A.DD2767E8@psind.com>
Date: Tue, 17 Jul 2001 22:14:50 -0400
From: "David J. Picard" <dave@psind.com>
Reply-To: dpicard@rcn.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Aaron Sethman <androsyn@ratbox.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: PATCH for Corrupted IO on all block devices
In-Reply-To: <Pine.LNX.4.33L2.0107172237030.6255-100000@squeaker.ratbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The issue was in a stack overflow in the test program, as Alexander
pointed out. Is the stack order different on Solaris et.al v. Linux?
Could this be why it worked so well on the other OS's? The correct
version of the program is as follows:

#include <stdio.h>
#include <assert.h>

#define TEST_SZ 25000000
#define RD_BUFF_SZ 5000
int main(int argc, const char **argv, const char **env)
{
    FILE* fp;

    if(argc > 1) fp = fopen(argv[1], "r+");
    else fp =tmpfile();
    if(NULL != fp) {
        int j = -1;
	off_t o;
        while(1) {
            if(++j != TEST_SZ) {
	        if (j == (TEST_SZ - RD_BUFF_SZ) ) o = ftello(fp);
                fwrite(&j, sizeof(int), 1, fp);
            } else {
                int i, buffer[RD_BUFF_SZ];
		fflush(fp);
                fseek(fp, o, SEEK_SET);
                fread(buffer, sizeof(int), RD_BUFF_SZ, fp);
                printf("Validating end of file writes (%d %d)\n",
sizeof(int),
		       RD_BUFF_SZ);
                for(i = (RD_BUFF_SZ - 1); i >= 0; i--) {
                    assert(buffer[i] == --j) ;
                }
                rewind(fp);
		j = -1;
            }
        }
        return 1;
    }
    return 0;
}


Aaron Sethman wrote:
> 
> I'd just like to add that the test program bombs on a reiserfs filesystem
> as well.  So if their is some sort of issue, its not just related to ext2.
> 
> Regards,
> 
> Aaron
> 
> On Tue, 17 Jul 2001, Linus Torvalds wrote:
> 
> >
> > On Tue, 17 Jul 2001, David J. Picard wrote:
> > >
> > > Basically, what is happening is the read requests are being pushed to
> > > the front of the IO queue - before the preceding write for the same
> > > sector.
> >
> > This is a bug in the USER, not in the code.
> >
> > The locking is NOT supposed to be done at the elevator level (or, indeed
> > at ANY _io_ level), but must be done by upper layers.
> >
> > If upper layers do not do this locking, then THAT is the bug.
> >
> > What filesystem do you see the bug with?
> >
> >               Linus
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> >

-- 
David J. Picard
  dave@psind.com

If you can keep your head when all about you are losing theirs,
  then you clearly don't understand the situation.
