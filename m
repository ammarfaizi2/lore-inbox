Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271723AbRH0OBb>; Mon, 27 Aug 2001 10:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271726AbRH0OBW>; Mon, 27 Aug 2001 10:01:22 -0400
Received: from relay01.cablecom.net ([62.2.33.101]:34571 "EHLO
	relay01.cablecom.net") by vger.kernel.org with ESMTP
	id <S271723AbRH0OBR>; Mon, 27 Aug 2001 10:01:17 -0400
Message-Id: <200108271401.f7RE1Xk27375@mail.swissonline.ch>
Content-Type: text/plain; charset=US-ASCII
From: Christian Widmer <cwidmer@iiic.ethz.ch>
Reply-To: cwidmer@iiic.ethz.ch
Subject: proc file system
Date: Mon, 27 Aug 2001 16:01:29 +0200
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i need to report more then 4KB of data to the /proc and found a short
note in "linux device drivers 2" how to do. so i wrote some functions
that look like that one below.

static int my_read_proc(char *page, char **start, off_t offset,
                       int count, int *eof, void* data)

{
  static int  myIndex = 0, done = 0;
  int en = 0, max = count - 256;

  for(;myIndex < MAX_INDEX; myIndex++){
	len += sprintf(page+len, "hier some info of dynamic length\n");
	if(len > max){		// still data left
           (*start) = page;
            return len;
         }	
  }
  myIndex = 0;			// all data out
  *eof = 1
  done   = 1;
  return len;
}

not all of my output gets printed. looks like the data from the last 
call to my function disapiers. thats wy i thought to delay the eof
one call by:

static int my_read_proc(char *page, char **start, off_t offset,
                        int count, int *eof, void* data)

{
  static int  myIndex = 0, done = 0;
  int len = 0, count = offset - 256;
  if(done){				// now we say that we are done
    *eof = 1;
    done = 0;
    return 0;
  }
 for(;myIndex < MAX_INDEX; myIndex++){
	len += sprintf(page+len, "hier some info of dynamic length\n");
	if(len > max){			//more data left
           (*start) = page;
            return len;
         }	
 }
 (*start) = page;			//were done (but we dont say)
 myIndex = 0;
 done   = 1;
 return len;
}

it does not cut any more some of my data. but endlessly dumping my data to 
the terminal. after delaying the reset of 'done' as long as offest dont get
back to 0 it seems to work.

  if(done & offset){			// wait until linux seems to have the
					// same view of the proc-files state
    *eof = 1;
    return 0;
  }else done = 0;



can anybody tell me wats going on here - i'm confused what do i not know?

