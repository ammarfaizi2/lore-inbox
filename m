Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVBOKDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVBOKDA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 05:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVBOKDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 05:03:00 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:16054 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261666AbVBOKCw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 05:02:52 -0500
From: Vincent Roqueta <vincent.roqueta@ext.bull.net>
Organization: BULL SA
To: linux-kernel@vger.kernel.org
Subject: UDP and e1000 : Simple test,  little bugs.
Date: Tue, 15 Feb 2005 11:08:46 +0100
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Message-Id: <200502151108.46768.vincent.roqueta@ext.bull.net>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 15/02/2005 11:11:32,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 15/02/2005 11:11:33,
	Serialize complete at 15/02/2005 11:11:33
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I am working on NFS interoperabiity and I experiment some problems with UDP. 
The problem appear between the linux 2.6.10rc1 and 2.6.10rc2, and is still 
present in the last kernel (2.6.11rc3)

With NFSv3:
Client send a 32k file splited into 22 IP fragments. The problem is the server 
only receive 17 fragments.
More investigation tell me that the server reveive 17 fragments because the 
client only send 17  IP fragments.

As the NFS client code is exactly the same between the 2.6.10rc1 and 2.6.10rc2 
I tried to write a simple UDP client server, to be sure there is no relation 
between this bug and NFS.

Client create a buffer of X bytes and fill it with the 'A' symbol. Then it 
write it over a udp socket (sendto).
Server read the first 1024KB sent.

If X is <26000 the write is done with sucess.
Else it fail. (Typicaly for a 32KB size, as for NFS)

Network card is the intel e1000 ethernet card. I tried with rxpolling turned 
on and off. Bug doesnot appear in loopback.

Anyone interrested in that?

Vincent ROQUETA


/****************************************
 * Simple Client 
* Port : 9999
* argument 1 : buffer size to send
* argument 2 : server ip adress.
 ****************************************/
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <stdio.h>

int main (int argc, char * argv[])
{
    int sock;
    struct sockaddr_in name;
    int size;
    char *ip;
    
    
    size=atoi(argv[1]);    
    ip=argv[2];
    char DATA[size];

    
    sock = socket (AF_INET, SOCK_DGRAM, 0);
    if (sock < 0)
    {
        perror ("socket");
        return 1;
    }
    bzero (&name, sizeof (name));
    memset(DATA, 'A', sizeof(DATA));

    name.sin_family      = AF_INET;
    name.sin_addr.s_addr = inet_addr  (ip); 
    name.sin_port = htons(9999);

    fprintf(stdout, "client UDP, port: %d\n", ntohs(name.sin_port));

    if(sendto(sock,DATA,sizeof(DATA),0,(struct sockaddr 
*)&name,sizeof(name))<0)
    {
        perror("sendto");
        close(sock);
        return 1;
    }  close(sock);
    return 0;
}

/********************************************
* Simple server
* port 9999
********************************************/
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <stdio.h>

int main (int argc, char * argv[])
{
    int sock;
    size_t length;
    struct sockaddr_in name;
    char buf [1024];
    int nbr=0;
    while (1)
    {

        bzero (&name, sizeof (name));
        sock = socket (AF_INET, SOCK_DGRAM, 0);
        if (sock < 0)
        {
            perror ("socket");
            return 1;
        }

        name.sin_family      = AF_INET;
        name.sin_addr.s_addr = INADDR_ANY;  
        name.sin_port        = htons(9999);

        if (bind (sock, (struct sockaddr *)&name, sizeof (name)) < 0)
        {
            perror ("bind");
            close (sock);
            return 1;
        }
        if (getsockname (sock, (struct sockaddr *)&name, &length) < 0)
        {
            perror ("getsockname");
            close (sock);
            return 1;
        }

        printf ("Socket UDP  port #%d\n", ntohs (name.sin_port));
        nbr++;
        printf("read nb%d\n",nbr);
        if(read(sock, buf, 1024)<0)
        {
            perror ("read");
            close (sock);
            return 1;
        }

       printf ("%s", buf);

        printf("\n");
        close (sock);
    }

    return 0;
}
