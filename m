Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267931AbRGRVTP>; Wed, 18 Jul 2001 17:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267930AbRGRVTF>; Wed, 18 Jul 2001 17:19:05 -0400
Received: from smarty.smart.net ([207.176.80.102]:22802 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S267931AbRGRVSz>;
	Wed, 18 Jul 2001 17:18:55 -0400
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200107182133.RAA00850@smarty.smart.net>
Subject: elevator with layers
To: linux-kernel@vger.kernel.org
Date: Wed, 18 Jul 2001 17:33:58 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A guy posted some test results based on some code like this...

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
        int o;
        while(1) {
            if(++j != TEST_SZ) {
                if (j == (TEST_SZ - RD_BUFF_SZ) ) o = ftello(fp);
                fwrite(&j, sizeof(int), 1, fp);
            } else {
                int i, buffer[RD_BUFF_SZ];
                fflush(fp);
                fseek(fp, o, SEEK_SET);
                fread(buffer, sizeof(int), sizeof(buffer), fp);
                printf("Validating end of file writes\n");
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

That's not it exactly. o wasn't an int. Probably a long long by some other
name. I don't know what he's trying to do with the above, but I believe
the following has the same basic action...

#include <stdio.h>
#include <assert.h>

int main () {

int i, j, buffer[5000], isize, bufsize;

isize = sizeof(int);
bufsize = sizeof(buffer);

FILE * stream = tmpfile();

top:    j = -1;
        fflush(stream);
        fseek(stream, 0, SEEK_SET);
        fread(buffer, isize, bufsize, stream);
        printf("x            ");
        for(i = 4999; i >=0 ; i --) { assert(buffer[i] == --j) ; }
        rewind(stream);
goto top ;
}


which should be a bit easier to assess if I'm right about what it's doing.
There's probably still some stuff there that can go away, but I'm not
familiar with rewind() and friends.

Rick Hohensee
						www.clienux.com
