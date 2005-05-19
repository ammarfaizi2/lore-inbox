Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262441AbVESLxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbVESLxO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 07:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbVESLxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 07:53:14 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:33756 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262441AbVESLxH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 07:53:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cPjowJ034SIXSpR07mBf9xMvwPQ2S83490kk/X6vZritM+a/qK2hEaZYHsykfeZHyQdIviL+jVnzsHODw6MvkPMMYVi5HHJDrjXREpzj+kP5rmpnxC3ivfEgOrmaHG+3FnjlR4NYfKyY6NnAL25j55/UucTyhL4+sDJM6MqEzxQ=
Message-ID: <2538186705051904531382021a@mail.gmail.com>
Date: Thu, 19 May 2005 07:53:06 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2.6.12-rc4-mm2] drivers: (dynamic sysfs callbacks) update device attribute callbacks
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
In-Reply-To: <253818670505190445647685ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <253818670505190435648367db@mail.gmail.com>
	 <253818670505190445647685ed@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the previously mentioned perl script. Its quite simplistic,
and accepts the filename of a source file to update as a parameter, or
uses stdin/stdout if no parameters are given. To update a whole tree
using the below just use something like:

find linux-2.6.12-rc4 -type f -exec ./updatedyncallbackdevattr.pl {} \;

This script should catch every device_attribute callback, including
multiline function signatures and embedded in macros. If it fails to
catch something please let me know.

Thanks,
Yani

---
#!/usr/bin/perl

use strict;

my $infile=shift;

if(!defined $infile){
        open(IN,"<&STDIN") or die "Could not open an input stream";
}else{
        open(IN,"<$infile") or die "Could not open an input stream";
}

my $subs = 0;
my $code = "";

while(<IN>){$code.=$_};
close(IN);

$code =~ s/(ssize_t[\s\\]+?[^(;]+?\(\s*?struct[\s\\]+?(?:device)[\s\\]*?\*[^,);]*?,)([\s\\]*?char[\s\\]*?\*[^,);]*?[\s\\]*?\))/$1
struct device_attribute *attr,$2/gs && $subs++;
$code =~ s/(ssize_t[\s\\]+?[^(;]+?\(\s*?struct[\s\\]+?(?:device)[\s\\]*?\*[^,);]*?,)([\s\\]*?const[\s\\]+?char[\s\\]*?\*[^,);]*?[\s\\]*?,[\s\\]*size_t[^,);]*?[\s\\]*\))/$1
struct device_attribute *attr,$2/gs && $subs++;

if($subs){
        if(!defined $infile){
                open(OUT,">&STDOUT") or die "Could not open an output stream";
        }else{
                open(OUT,">$infile") or die "Could not open an output stream";
        }
        $|;
        print OUT $code;
        close(OUT);
        $infile && print STDOUT "$infile updated.\n";
}
