Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbUCJMnd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 07:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbUCJMnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 07:43:33 -0500
Received: from ext-nj2gw-3.online-age.net ([216.35.73.165]:17865 "EHLO
	ext-nj2gw-3.online-age.net") by vger.kernel.org with ESMTP
	id S262591AbUCJMm6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 07:42:58 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6521.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: PROBLEM::  irreversible Memory growth of process in mmap()-munmap() calls 
Date: Wed, 10 Mar 2004 18:12:45 +0530
Message-ID: <62DD37292ED5464CBB142913FC65F8AB0A617E63@BANMLVEM01.e2k.ad.ge.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PROBLEM::  irreversible Memory growth of process in mmap()-munmap() calls 
Thread-Index: AcQGZSaiK5by9CtcRM6xOg5kJLssOgAOQF4g
From: "Kumar, Rajneesh \(MED\)" <rajneesh.kumar@med.ge.com>
To: "Michael Frank" <mhf@linuxmail.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Mar 2004 12:42:54.0815 (UTC) FILETIME=[355D36F0:01C4069D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Frank

   Here is the "pseudo code" for the program
     
   create 4 files of different sizes.Then wrote a program , as below:

     while ( for arbitrary time)
     {
           fopen (  first file )
           mmap (  first file )
           Note the memory-size of process

          munmap ( the file)
          Note the memory-size of process again
          fclose ( first file)
    
         //Repeat the above Sequence for 2nd File
         //Repeat the above Sequence for 3rd File
         //Repeat the above Sequence for 4th File
    }


  Full code is here :

#include <sys/mman.h>
#include <iostream.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>

#define MEM_MULTIPLIER 1

int main()
{
    char *mapAddress = NULL;
    int length = 10000526;
    int status =0 ;
    sleep(10 );     // start top on other terminal with this pid to watch size growth
    int fd = 0;
    for( int i = 0 ; i<6 ; i++) //arbitrary number of iterations
    {
      {

              fd = open("./a.txt", O_RDONLY);
              if (fd == -1)
              {
                  cout<<" Could Not open a.txt"<<endl;
                  return 1;
             }
             mapAddress = (char*) mmap(0, length, PROT_READ, MAP_SHARED, fd, 0);
             if (mapAddress == (char*)-1)
             {
                  cout<<" Map Failed for a.txt "<<endl ;
                  mapAddress = NULL;
                  return 1;
             }
             cout<<"Watch out the size now after mapping a.txt"<<endl;
             sleep(4);
             close(fd);    
             st = munmap(mapAddress, length);
             if (status != 0)
             {
                 cout<<"Failed Unmap: "<<endl ;
                 return 1 ;
            }

            cout<<"Watch out the size now after unmapping a.txt"<<endl;
            sleep(4);
            mapAddress = NULL;
      }
      {
           int fd = open("./b.txt", O_RDONLY);
           if (fd == -1)
           {
               cout<<" Could Not open b.txt"<<endl;
               return 1;
           }
           mapAddress = (char*)mmap(0, length, PROT_READ, MAP_SHARED, fd, 0);
           if (mapAddress == (char*)-1)
           {
               cout<<"Failed Mmap: "<<endl ;
               return 1;
           }
          cout<<"Watch out the size now after mapping b.txt"<<endl;
          sleep(4);
          close(fd);
          status = munmap(mapAddress, length);
         if (status != 0)
         {
         
            cout<<" Unmapped faild "<<endl;
            return 1;
        }
        cout<<"Watch out the size now after unmapping b.txt"<<endl;
       sleep(4);
       mapAddress = NULL;
    }
   {
       length = length* MEM_MULTIPLIER ;
       int fd = open("./c.txt", O_RDONLY);
      if (fd == -1)
      {
        cout<<" Could Not open c.txt"<<endl;
        return 1;
       }
      mapAddress = (char*)mmap(0, length, PROT_READ, MAP_SHARED, fd, 0);
      if (mapAddress == (char*)-1)
       {
           cout<<" Map Failed for a.txt "<<endl ;
            return 1;
        }
         
       cout<<"Watch out the size now after mapping c.txt"<<endl;
       sleep(4);
       close(fd);
        status = munmap(mapAddress, length);
       if (status != 0 )
       {
          cout<<" Unmapped faild "<<endl;
          return 1;
        }
       cout<<"Watch out the size now after unmapping c.txt"<<endl;
       sleep(4);
       mapAddress = NULL;
   }
   {
       length = length* MEM_MULTIPLIER ;
       cout<<"Watch out the size now before mapping d.txt for size "<<length <<endl;
       sleep(4);

      int fd = open("./d.txt", O_RDONLY);
      if (fd == -1)
      {
        cout<<" Could Not open d.txt"<<endl;
        return 1;
       }
      mapAddress = (char*)mmap(0, length, PROT_READ, MAP_SHARED, fd, 0);
      if (mapAddress == (char*)-1)
       {
           cout<<" Map Failed for d.txt "<<endl ;
            return 1;
        }
       cout<<"Watch out the size now after mapping d.txt"<<endl;
       sleep(4);
       close(fd);
        st = munmap(mapAddress, length);
       if (st != 0)
       {
          cout<<" Unmapped faild "<<endl;
          return 1;
        }
       cout<<"Watch out the size now after unmapping d.txt"<<endl;
       sleep(4);
       mapAddress = NULL;
    }
 }
 sleep(10);
}







Regards
Rajneesh Kumar

GSP, GEMS-GTO
GE Medical Systems
John F Welch Technology Center
#152, EPIP. Phase 2
Whitefield, Bangalore.560 066

Ph :        (080) - 2503 3412
Dialcom: *901 3412
mail:       rajneesh.kumar@med.ge.com


-----Original Message-----
From: Michael Frank [mailto:mhf@linuxmail.org]
Sent: Wednesday, March 10, 2004 11:31 AM
To: Kumar, Rajneesh (MED)
Subject: Re: PROBLEM:: irreversible Memory growth of process in
mmap()-munmap() calls 


On Wed, 10 Mar 2004 10:48:32 +0530, Kumar, Rajneesh (MED) <rajneesh.kumar@med.ge.com> wrote:

> Hi Frank,
>    I suspect two things:
>   1. Either map() unmap() has an issue
>   2. top in linux does not give exact memory size of process.
>
>  whats u'r opinion
>

Please post a short program which demos the problem on LKML. This is
the only way to get help from the kernel developers to track down
the problem.

Regards
Michael
