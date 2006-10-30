Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161208AbWJ3KZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161208AbWJ3KZx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 05:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161209AbWJ3KZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 05:25:52 -0500
Received: from imag.imag.fr ([129.88.30.1]:56261 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S1161208AbWJ3KZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 05:25:52 -0500
Message-ID: <4545D2FA.3030802@imag.fr>
Date: Mon, 30 Oct 2006 11:24:58 +0100
From: Videau Brice <brice.videau@imag.fr>
Reply-To: brice.videau@imag.fr
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Strange connect behavior
Content-Type: multipart/mixed;
 boundary="------------060104070701000504030508"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Mon, 30 Oct 2006 11:25:02 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: brice.videau@imag.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060104070701000504030508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

While writing some client server application in c, we noticed a strange 
behavior : if we try to connect endlessly to a given local port where 
nobody is listening, and if the port is >= to 32768, after several 
thousands tries ( Connection refused ) connect will return 0.
This behavior is not exhibited when port is < 32768.

We confirmed this behavior in kernel 2.6.17-10, 2.6.18-1, 2.6.8, on x86 
and 2.4.21-32 on ia64, on several hardware configurations.
Distribution is debian or ubuntu.

Attached is a source file that demonstrate this behavior.
./a.out port_number

Sample execution :

./a.out 35489
Out port : 35489
connect try 1 failed : Connection refused
connect try 2 failed : Connection refused
connect try 3 failed : Connection refused
.....
connect try 6089 failed : Connection refused
connect try 6090 failed : Connection refused
Connection success : 6091 try
Connection closed
last error : Connection refused


Is this behavior to be expected?
Can it be disabled?

Thanks in advance.

Regards,

Brice Videau

--------------060104070701000504030508
Content-Type: text/x-csrc;
 name="client.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="client.c"

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <string.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <errno.h>

int main(int argc, char **argv) {
   unsigned short out_port = 35000;
   char * endptr;
   struct sockaddr_in server_address;
   int out_socket;
   int i=1;

   if( argc > 1 ) {
      out_port = (unsigned short) strtol(argv[1], &endptr, 10);
      errno = 0;
      if(errno != 0 || out_port == 0 || endptr == argv[1] ) {
         perror("Invalid port number");
         exit(1);
      }
   }
   printf( "Out port : %hu\n", out_port );
   fflush(NULL);

   memset( &server_address, 0, sizeof(struct sockaddr_in) );
   server_address.sin_family = AF_INET;
   server_address.sin_port = htons(out_port);
   if ( inet_pton( AF_INET, "127.0.0.1", &(server_address.sin_addr) ) <= 0 ) {
      perror("inet_pton error");
      exit(1);
   }

   if ( (out_socket = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
      perror("socket error");
      exit(1);
   }

   while (connect(out_socket, (struct sockaddr *) &server_address, sizeof(struct sockaddr_in)) < 0)
   {
      fprintf(stderr,"connect try %i failed : ",i);
      perror("");
      fflush(NULL);
      i++;
   }

   printf("Connection success : %i try\n",i);
   fflush(NULL);

   if( close(out_socket) < 0 ) {
      perror("close error");
      exit(1);
   }

   printf("Connection closed\n");
   fflush(NULL);

   fprintf(stderr,"last error : ");
   perror("");

   return 0;
}

--------------060104070701000504030508--
