Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279808AbRKIKtR>; Fri, 9 Nov 2001 05:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279812AbRKIKtH>; Fri, 9 Nov 2001 05:49:07 -0500
Received: from addleston.eee.nott.ac.uk ([128.243.70.70]:52202 "HELO
	addleston.eee.nott.ac.uk") by vger.kernel.org with SMTP
	id <S279808AbRKIKtA>; Fri, 9 Nov 2001 05:49:00 -0500
Date: Fri, 9 Nov 2001 10:48:58 +0000 (GMT)
From: Matthew Clark <matt@eee.nott.ac.uk>
X-X-Sender: <matt@perry>
To: <linux-kernel@vger.kernel.org>
Subject: dev driver / pci throughput
Message-ID: <Pine.OSF.4.31.0111091022010.26869-100000@perry>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear kernel-list,

I am writing a dev driver in which large amounts of data are
passed from user space to PCI device memory and I am seeing a
far lower throughput than I expected.  I know this is likely to
be high architecture dependant but I would appreciate some
general guidance.

The essential bit of code looks like

#define CHUNK	512->4096 depending on implementation

static ssize_t BSL_write(..., const char *buf, size_t count..){
char chunk[CHUNK];
int	i,pos,
	for(i=0,pos=0;i<amount of data;i++,pos+=CHUNK){
		copy_from_user(buff,buf+pos,CHUNK);
		/* reorder data				*/
		/* not significant in throughput	*/
		for(k=0;k<CHUNK;k++){
                        chunk[k]=buff[B_SM(j+k)];
			}
		memcpy_toio(MEM_reg+pos+i*CHUNK+j,chunk,CHUNK);
		}
	return count;
	}
+ lots of not important details-----

MEM_reg=ioremap(pci_resource_start(dev,B_SM_MEM)&PCI_BASE_ADDRESS_MEM_MASK,REG_SIZE);



Basically it reads a big buffer from user space, scrambles the
byte ordering (according to B_SM) and puts it onto the PCI
device memory.

** I currently get 3-4Mb/s throughput (on a fairly poor x86 pc),
   this is about 1/10 of what I expected to achieve.

** The CHUNK size is not an important factor above 512 bytes- it
   is contributing to 0.1 percent of the bottle neck.  This
   leads me to think that the copy_from overheads are small.

** The byte ordering is not significant, removing it or
   replacing it with a null command indicates it contributes
   ~0.1 percent of the bottleneck.

** The transfer size will always exceed any cache sizes in the
   system.


I will go onto implementing an mmap method sometime later but as
the essential memory / PCI memory bandwidth remains the same I
don't think it will make much difference- From testing with
different transfer sizes overheads seem small provided a minimum
transfer size of 512 bytes is enforced.

Any thoughts?  pointers towards profiling this code, typical
throughputs, improving throughput etc gratefully received.

Thanks matt

--------
Thanks for the previous help on interrupts etc-

