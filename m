Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262849AbVD2R15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262849AbVD2R15 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 13:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbVD2R15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 13:27:57 -0400
Received: from pD9E8B3D1.dip.t-dialin.net ([217.232.179.209]:38148 "EHLO
	gateway2.croq.loc") by vger.kernel.org with ESMTP id S262849AbVD2RZr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 13:25:47 -0400
Message-ID: <42726DDD.1010204@free.fr>
Date: Fri, 29 Apr 2005 19:24:45 +0200
From: Olivier Croquette <ocroquette@free.fr>
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: fr-fr, en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: setitimer timer expires too early
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello


I wrote a program which uses setitimer to implement a usleep() equivalent.

The setitimer man page states:

"
Timers will never expire before the requested time, instead
expiring some short, constant time afterwards, dependent on the system
timer resolution  (currently  10ms).
"

I think that the current implementation of setitimer() (or something
related) is broken.

Or may be I use setitimer() in the wrong way!?

You will find the program below, and also some results under kernels
2.4.20 and 2.6.11.7 (both SuSE) on a x86 32bits PC.

I also tested it under MacOS X.3 and SunOS 5.8, and unter these OS all 
is OK!


Each line represents one dectected problem with the format:
specified_delay real_delay

("problem" means real_delay < specified_delay )

As you can see, there is a bunch of premature timer expirations.

There seems also to give a kind of pattern:

For kernel 2.6, timers between
      "n" ms - 300 us and "n" ms expire too early
For kernel 2.4, timers between
     10*"n" ms - 600 us and 10*"n" ms expire too early

(with n integer)

Anyone have an idea?
Can you reproduce that?


Furthermore, the man page is not up-to-date about the the timer
resolution IMHA.
2.6 provides 1ms resolution for x86 (and what about other platforms?).

Do you know here can I find the maintainer?


Best regards

Olivier




#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/wait.h>





typedef unsigned long long int u_time_t; /* in microsecs */

static int handler_flag;

u_time_t gettime(void ) {

   struct timeval tv;

   if ( gettimeofday(&tv, NULL) ) {
     perror("gettimeofday()");
     return 0;
   }

   return (tv.tv_usec + tv.tv_sec * 1000000LL);
}


static void my_dummy_handler (int sig, siginfo_t *siginfo,
void *context) {
   handler_flag++;
   return ;
}


int isleep(u_time_t time, int return_on_any_signal) {
   struct itimerval  newtv;

   sigset_t  sigset;
   struct sigaction  sigact;

   if ( time == 0)
     return 0;

   /* block SIGALRM */

   sigemptyset (&sigset);
   sigaddset (&sigset, SIGALRM);
   sigprocmask (SIG_BLOCK, &sigset, NULL);

   /* set up our handler */
   sigact.sa_sigaction  = my_dummy_handler;
   sigemptyset(&sigact.sa_mask);
   sigact.sa_flags = SA_SIGINFO;
   sigaction (SIGALRM, &sigact, NULL);

   newtv.it_interval.tv_sec  = 0;
   newtv.it_interval.tv_usec = 0;
   newtv.it_value.tv_sec     = time / 1000000;
   newtv.it_value.tv_usec    = time % 1000000;

   if ( setitimer(ITIMER_REAL,&newtv,NULL) < 0 ) {
     perror("setitimer(set)");
     return 1;
   }

   sigemptyset (&sigset);
   sigsuspend (&sigset);
   return 0;

}

int main(void ) {
   u_time_t wait;

   srand(gettime());

   for (wait= 1; wait<30000; wait++) {
     int i;
     for ( i=0 ; i<1; i++) {
     u_time_t t1, t2;
     u_time_t diff;

     t1 = gettime();


     handler_flag = 0;
     isleep(wait,0);
     if ( handler_flag != 1 ) {
       fprintf(stderr,
"Problem with the handler flag (%d)!\n",handler_flag);
     }
     // usleep(wait);


     t2 = gettime();
     diff = t2 - t1;
     if ( diff < wait )
       printf("%llu %llu %llu %llu\n",t1, t2, wait,diff);
     }
   }
   return 0;
}



/*


   Kernel 2.6.11.7
     746 717
     751 632
     762 645
     806 731
     821 816
     841 758
     851 822
     855 534
     871 813
     878 833
     881 860
     888 689
     891 825
     902 727
     911 818
     921 830
     926 729
     931 880
     941 878
     945 873
     950 889
     951 830
     958 942
     962 927
     971 851
     972 967
     974 728
     981 881
     988 985
     991 727
     992 988
     995 988
     996 995
     998 842
     999 994
     1753 1727
     1765 1679
     1789 1726
     1795 1714
     1807 1733
     1819 1728
     1843 1747
     1855 1704
     1867 1743
     1879 1857
     1891 1747
     1903 1735
     1915 1712
     1927 1610
     1939 1806
     1951 1812
     1952 1920
     1963 1747
     1975 1705
     1977 1920
     1979 1955
     1981 1861
     1990 1969
     1993 1747
     1995 1990
     1997 1985
     1999 1995
     2778 2757
     2843 2796
     2852 2768
     2853 2768
     2863 2801
     2879 2848
     2883 2882
     2900 2885
     2910 2859
     2920 2871
     2930 2769
     2935 2931
     2940 2877
     2950 2833
     2960 2891
     2970 2773
     2972 2965
     2979 2915
     2980 2932
     2981 2979
     2985 2937
     2990 2903
     2992 2937
     2993 2991
     2994 2993
     2997 2985
     2998 2992
     3351 3281
     3615 3279
     3847 3821
     3862 3847
     3867 3842
     3877 3846
     3882 3814
     3890 3799
     3892 3860
     3897 3854
     3907 3859
     3912 3904
     3922 3835
     3927 3919
     3937 3799
     3942 3854
     3952 3862
     3957 3861
     3967 3844
     3972 3858
     3974 3951
     3982 3843
     3984 3969
     3987 3908
     3988 3986
     3997 3836
     3999 3977
     4719 4655
     4770 4633
     4830 4781
     4854 4744
     4866 4720
     4890 4861
     4914 4855
     4932 4900
     4950 4734
     4970 4783
     4974 4828
     4981 4972
     4990 4972
     4991 4985
     4993 4968
     4995 4978
     4996 4995
     4998 4842
     4999 4991
     5520 5219
     5644 5622
     5714 5570
     5724 5581
     5740 5733
     5744 5694
     5752 5751
     5756 5741
     5760 5724
     5764 5708
     5772 5743
     5776 5677
     5782 5730
     5786 5729
     5790 5735
     5794 5599
     5802 5741
     5807 5558
     5810 5734
     5814 5707
     5822 5572
     5826 5692
     5830 5717
     5834 5687
     5836 5751
     5840 5703
     5844 5583
     5852 5742
     5854 5827
     5856 5735
     5860 5735
     5864 5564
     5869 5858
     5872 5722
     5874 5851
     5876 5734
     5880 5730
     5884 5756
     5888 5856
     5889 5878
     5892 5724
     5894 5594
     5898 5797
     5902 5841
     5904 5861
     5906 5720
     5910 5733
     5914 5727
     5918 5843
     5922 5726
     5926 5686
     5930 5727
     5934 5740
     5935 5331
     5946 5894
     5947 5927
     5956 5947
     5963 5831
     5968 5868
     5972 5848
     5988 5984
     5994 5986
     5995 5988
     5997 5921
     5998 5989
     5999 5997
     6547 6546
     6560 6464
     6622 6508
     6707 6642
     6729 6508
     6730 6512
     6754 6699
     6780 6718
     6785 6423
     6786 6718
     6816 6769
     6835 6828
     6846 6735
     6855 6845
     6870 6858
     6882 6863
     6885 6841
     6906 6722
     6915 6885
     6921 6755
     6923 6919
     6926 6470
     6935 6714
     6938 6931
     6944 6841
     6959 6834
     6964 6943
     6971 6874
     6974 6931
     6975 6866
     6987 6960
     6990 6943
     6995 6713
     6997 6973
     6998 6997
     7850 7845
     7855 7842
     7865 7857
     7870 7862
     7880 7854
     7885 7829
     7890 7868
     7895 7841
     7900 7866
     7905 7865
     7913 7845
     7915 7806
     7926 7847
     7930 7892
     7935 7858
     7940 7847
     7945 7858
     7950 7848
     7960 7852
     7965 7869
     7970 7796
     7975 7891
     7980 7839
     7985 7890
     7986 7984
     7988 7841
     7990 7845
     7991 7966
     7993 7992
     7995 7829
     7996 7985
     7998 7978
     8856 8849
     8858 8794
     8878 8817
     8888 8884
     8898 8852
     8906 8850
     8908 8874
     8918 8846
     8928 8875
     8938 8863
     8948 8889
     8956 8840
     8958 8783
     8968 8883
     8978 8906
     8988 8896
     8990 8987
     8994 8983
     8995 8991
     8998 8847
     9749 9704
     9979 9943
     9993 9980
     9994 9990
     9995 9994
     9996 9986
     9997 9990
     9998 9996
     10735 10731
     10759 10744
     10771 10723
     10807 10723
     10843 10764
     10855 10838
     10879 10729
     10891 10739
     10893 10889
     10915 10740
     10927 10855
     10943 10936
     10951 10725
     10957 10922
     10963 10723
     10977 10968
     10987 10720
     10989 10987
     10993 10926
     10995 10989
     10996 10995
     10997 10987
     11485 11268
     11532 11309
     11866 11844
     11891 11848
     11908 11846
     11916 11838
     11930 11927
     11941 11843
     11955 11934
     11966 11840
     11971 11961
     11980 11932
     11991 11878
     11992 11959
     11993 11989
     11994 11985
     11995 11992
     11996 11988
     11997 11988
     11998 11993
     12774 12362
     12926 12839
     12962 12945
     12986 12982
     12992 12990
     12993 12988
     12994 12991
     12995 12991
     12996 12988
     12997 12995
     12998 12984
     13984 13983
     13986 13540
     13987 13985
     13991 13967
     13995 13988
     13996 13990
     13997 13982
     14672 14422
     14682 14424
     14691 14388
     14720 14547
     14729 14339
     14927 14921
     14950 14790
     14953 14898
     14967 14925
     14973 14958
     14984 14852
     14985 14984
     14989 14988
     14993 14966
     14994 14980
     14995 14692
     14996 14962
     15902 15836
     15919 15896
     15944 15926
     15964 15963
     15969 15921
     15977 15845
     15979 15966
     15991 15990
     15992 15990
     15994 15903
     15995 15986
     15997 15988
     16896 16849
     16977 16966
     16979 16953
     16980 16979
     16989 16987
     16991 16988
     16992 16991
     16995 16988
     16996 16982
     16997 16996
     17805 17794
     17990 17988
     17992 17989
     17993 17990
     17994 17991
     17995 17980
     17996 17994
     17997 17991
     18886 18836
     18958 18940
     18974 18927
     18984 18968
     18985 18979
     18990 18986
     18991 18987
     18993 18989
     18995 18986
     18996 18987
     18997 18993
     19831 19624
     19867 19816
     19883 19871
     19896 19828
     19911 19840
     19939 19541
     19952 19951
     19964 19953
     19976 19965
     19986 19871
     19987 19982
     19989 19547
     19991 19633
     19992 19977
     19993 19974
     19994 19984
     19995 19989
     19996 19995
     20928 20925
     20954 20937
     20970 20950
     20990 20986
     20992 20989
     20993 20989
     20994 20992
     20995 20986
     20996 20985
     21853 21843
     21928 21838
     21947 21928
     21955 21945
     21972 21941
     21991 21988
     21992 21989
     21993 21982
     21995 21988
     22929 22845
     22943 22924
     22945 22933
     22947 22545
     22992 22988
     22993 22985
     22995 22931
     22996 22989
     23782 23286
     23869 23595
     23937 23930
     23941 23904
     23966 23955
     23991 23884
     23992 23985
     23993 23989
     23994 23992
     23995 23991
     23996 23983
     24992 24985
     24993 24989
     24994 24987
     24995 24989
     24996 24990
     25868 25861
     25936 25933
     25943 25855
     25961 25936
     25965 25930
     25986 25944
     25987 25986
     25988 25986
     25992 25985
     25993 25987
     25994 25993
     25995 25985
     25996 25984
     26981 26949
     26990 26989
     26992 26552
     26993 26984
     26994 26986
     26995 26993
     27965 27855
     27989 27932
     27990 27985
     27992 27991
     27993 27982
     27994 27990
     27995 27991
     28948 28935
     28972 28942
     28980 28859
     28988 28983
     28993 28988
     28994 28985
     28995 28993
     29993 29986
     29994 29987
     29995 29992



   Kernel 2.4.20
     9479 9338
     9579 9338
     9654 9628
     9679 9375
     9746 9733
     9756 9683
     9762 9716
     9779 9341
     9797 9788
     9807 9702
     9829 9821
     9848 9758
     9858 9673
     9879 9341
     9899 9774
     9909 9751
     9919 9872
     9929 9808
     9950 9751
     9952 9934
     9960 9673
     9962 9948
     9972 9952
     9979 9387
     9980 9969
     9984 9971
     9988 9983
     9992 9927
     9996 9942
     9998 9976
     19254 19165
     19404 19386
     19454 19376
     19504 19339
     19604 19368
     19654 19379
     19704 19383
     19754 19372
     19804 19357
     19810 19777
     19829 19789
     19854 19397
     19860 19770
     19879 19805
     19904 19315
     19910 19777
     19929 19802
     19954 19341
     19960 19768
     19979 19797
     19993 19960
     19994 19993
     19998 19988
     19999 19998
     20000 19997
     29588 29372
     29736 29374
     29807 29707
     29836 29345
     29886 29786
     29907 29697
     29936 29336
     29949 29933
     29955 29761
     29970 29965
     29975 29968
     29978 29972
     29986 29793
     29996 29992
     29998 29978
     29999 29984
*/



