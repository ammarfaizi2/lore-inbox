Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312718AbSDPLtL>; Tue, 16 Apr 2002 07:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312885AbSDPLtK>; Tue, 16 Apr 2002 07:49:10 -0400
Received: from h24-68-93-250.vc.shawcable.net ([24.68.93.250]:28545 "EHLO
	me.bcgreen.com") by vger.kernel.org with ESMTP id <S312718AbSDPLtJ>;
	Tue, 16 Apr 2002 07:49:09 -0400
Message-ID: <3CBC0FA1.8070907@bcgreen.com>
Date: Tue, 16 Apr 2002 04:48:49 -0700
From: Stephen Samuel <samuel@bcgreen.com>
Organization: Just Another Radical
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: Re: More than 10 IDE interfaces
In-Reply-To: <20020411040845.GE14801@dark.x.dtu.dk> <3CB53D70.5070100@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It might be trowing bad money after good to do it, but why
not just put together a simple translation table.

rather than
drivenum=(driveletter - 'a')
and
driveletter=(drivenum+'a')

have translation tables, so that
	drivenum= chartodrivenum[driveletter]
    and
	driveletter= drivenumtoletter[drivenum]
If you're willing to map (almost) all of the printable
characters, you could get 46 controllers and 92 drives
(I'd refuse to map  ', ", \  or space)


You'd still be limited to one character, but it would, at least
make it easy to have 26 controllers and 52 drives  (and that's
just using upper and lower case characters!)

Martin Dalecki wrote:
> Baldur Norddahl wrote:
>> With there changes the kernel detects the extra interfaces and the 
>> disks on
>> them. They get some strange names like IDE< and the last disk is named 
>> hd{,
>> but I guess I can live with that :-)
> 
> 
> The cause of those funny names is well known in the 2.5.xx series.
> The solution to it will first involve a complete rewrite of the kernel
> parameter parsing in ide.


Geh... Here's even a perl script to generate the mapping..
Change the characters if you wish.

#!/bin/perl -w
# Copyright (c) 2002 Stephen Samuel
# Can be re-licensed under either GPL or LGPL
#
my (%drivenum, %idenum);
my (@drivenames, @idenames);

@drivenames= qw' a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F
		G H I J K L M N O P Q R S T U V W X Y Z 0 1 2 3 4 5 6 7 8 9 ';


@idenames= qw' 0 1 2 3 4 5 6 7 8 9 A B C D E F G H I J K L M N O P Q R S T U ' ;
$drivenames=scalar(@drivenames);
$idenames=scalar(@idenames);

print <<EOF1

/*
         defines the ide drive and controller mappings

*/

#define MAX_IDE_DEFINABLE $idenames
#define MAX_IDE_DRIVES_DEFINABLE $drivenames


EOF1
;
print "\n signed char drivenumtochar[$drivenames] ={";
$drivecount=0;
foreach $drive ( @drivenames ){
         printf "%s%s\t'%s'",
                 $drivecount?",":"",
                 ($drivecount & 7) ?"":"\n/*$drivecount*/" ,
                 $drive;
         $drivenum{$drive} = $drivecount++;
};
print "};\n\n";

print "signed char idenumtochar[$idenames] ={";
$idecount=0;
foreach $ide ( @idenames ){
         printf "%s%s\t'%s'",
                 $idecount?",":"",
                 ($idecount & 7) ?"":"\n/*$idecount*/" ,
                 $ide;
         $idenum{$ide} = $idecount++;
};
print "};\n\n";

$idecount=0;
foreach $ide ( @idenames ){
         $idenum{$ide} = $idecount++;
};

print "\n/* can't be 128 because of EBCDIC */\nsigned char chartodrivenum[256] ={";
for ($char=0; $char<256; $char++){
         printf "%s%s\t%s",
                 $char?",":"",
                 ($char & 7) ?"":"\n/*$char*/" ,
                 defined($drivenum{chr($char)})?$drivenum{chr($char)}:-1;
};
print "}; \n\n";


print " signed char chartoidenum[256] ={";
for ($char=0; $char<256; $char++){
         printf "%s%s\t%s",
                 $char?",":"",
                 ($char & 7) ?"":"\n/*$char*/" ,
                 defined($idenum{chr($char)})?$idenum{chr($char)}:-1;
}
print "}; \n\n"
-- 
Stephen Samuel +1(604)876-0426                samuel@bcgreen.com
		   http://www.bcgreen.com/~samuel/
Powerful committed communication, reaching through fear, uncertainty and
doubt to touch the jewel within each person and bring it to life.

