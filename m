Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263435AbRFKGKu>; Mon, 11 Jun 2001 02:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263437AbRFKGKk>; Mon, 11 Jun 2001 02:10:40 -0400
Received: from t2.redhat.com ([199.183.24.243]:27886 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S263435AbRFKGKZ>; Mon, 11 Jun 2001 02:10:25 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.10.10106111022240.7084-100000@blrmail> 
In-Reply-To: <Pine.LNX.4.10.10106111022240.7084-100000@blrmail> 
To: "SATHISH.J" <sathish.j@tatainfotech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: exec format error 
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-18430503040"
Date: Mon, 11 Jun 2001 07:08:08 +0100
Message-ID: <12339.992239688@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-18430503040
Content-Type: text/plain; charset=us-ascii


sathish.j@tatainfotech.com said:
> I have written a file system in 2.2.14 kernel similar to ramfs on 2.5
> kernel. I am able to register,mount and do file and directory
> operations. I tried to write a C program and compile it. The
> compilation gave me the object file. When i tried to run the object
> file it gave me an error  " cannot execute binary file". I entered gdb
> and  I could get the error "exec format error". What is exec format
> error and what is it because of? Please help me out with this info.

Assuming you did compile an executable, not just try to execute the .o file,
then your filesystem probably corrupted the executable. Building and linking
programs stresses parts of the filesystem that your other tests cannot
reach. In particular, it does lots of seeking and writing to places other
than the end of the file, which isn't trivial to do from a shell script. 

Try running the attached test program.


--
dwmw2


--==_Exmh_-18430503040
Content-Type: text/plain ; name="holey.c"; charset=us-ascii
Content-Description: holey.c
Content-Disposition: attachment; filename="holey.c"

#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>

/*  #define FILE_SIZE 50 * 4096 + 1 */
#define FILE_SIZE 106497
#define FILE_NAME "/mnt/jffs2/holey_file"
#define ITERATIONS 100000

#define SEED 123456789
#define min(x,y) ((x)<(y) ? (x):(y))
int randint (int low, int high)
{
  int normalized;

  normalized = (int) ( (float) rand() / ( (float) RAND_MAX / (float) (high - low + 1) ) );
  return (normalized + low);
}


int main (int argc, char *argv[])
{

  unsigned char holey_image[FILE_SIZE],
                holey_image_mem[FILE_SIZE], buf[FILE_SIZE];
  char *fname = malloc (strlen(FILE_NAME) + 8);
  char *errmsg = malloc (100);
  int holey_f;
  int start, size;
  int i, j;
  unsigned char c;
  int err;
  int written, newly_written, nwritten;

  srand (SEED);

  sprintf (fname, "%s%s%d", FILE_NAME, "-", getpid()); /* random file name to scribble on */

  if ((holey_f = open (fname, O_RDWR | O_CREAT | O_TRUNC, 
			S_IRUSR | S_IWUSR)) < 0) {
    perror ("Can't open holey file.");
    exit (-1);
  }

  c = (char) 0;
  /* initialize in memory check array, and buffer */
  for (i = 0; i < FILE_SIZE; i++) {
    holey_image[i] = holey_image_mem[i] = (char) 0;
    buf[i] = c++;
  }

 /* make a file with a big hole at the beginning */
  if (lseek (holey_f, FILE_SIZE-1, SEEK_SET) != FILE_SIZE-1) {
    perror ("Initial write of holey file failed");
    exit (-1);
  }

  c = '1';
  if (write (holey_f, &c, 1) != 1) {
    perror ("Write at and of hole failed");
    exit (-1);
  }
  holey_image[FILE_SIZE-1] = c;

  written = newly_written = 0;

  for (i = 0; i < ITERATIONS; i++) {

    size = randint (1, FILE_SIZE); /* how much to write */
    start = randint (0, (FILE_SIZE - size)); /* where to write it */
 /*     printf ("Start=%d, size=%d.\n", start, size); */

    lseek (holey_f, start, SEEK_SET);
    if ( (nwritten = write (holey_f, &buf, size)) != size) {
      sprintf (errmsg, "Could only write %d of %d bytes", nwritten, size); 
      perror (errmsg);
      exit (-1);
    }
    printf("%d bytes written to %d\n", size , start);

    written += size;
    newly_written += size;

    if (newly_written > 10000000) {
      printf ("%d bytes written.\n", written);
      newly_written = 0;
    }

    /* do the same copy in memory */
    memcpy (&holey_image[start], buf, size);
    memset(&holey_image_mem, 0x5a, FILE_SIZE);
    /* check to make certain that entire file looks like it's supposed to */
    lseek (holey_f, 0, SEEK_SET);
    if ( (read (holey_f, &holey_image_mem, FILE_SIZE)) != FILE_SIZE) {
      perror ("Rereading of file failed");
      exit (-1);
    }
   
    err = memcmp (&holey_image, &holey_image_mem, FILE_SIZE);
    if (err) {

      /* find the offset where they differ */
      j = 0;
      while (holey_image[j] == holey_image_mem[j]) 
	j++;

      printf ("File image is incorrect at offset %d. buf is %2.2X, file %2.2X\n", j, holey_image[j], holey_image_mem[j]);
      exit (-1);
    }

  } /* for (i... */

} /* main */
    
  

--==_Exmh_-18430503040--


